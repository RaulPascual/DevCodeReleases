//
//  HTTPClient.swift
//  XcodeReleases
//
//  Created by Raul on 30/5/23.
//

import Foundation

public class HTTPClient: NSObject {
    var urlProtocol: URLProtocol.Type?
    var dto = HTTPClientDTO()
    var session: URLSession {
        if let urlProtocol = urlProtocol {
            let configuration = URLSessionConfiguration.ephemeral
            configuration.protocolClasses = [urlProtocol]
            return URLSession(configuration: configuration)
        } else {
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = dto.timeout
            let session = URLSession(configuration: configuration,
                                     delegate: dto.certificateName != nil ? self : nil,
                                     delegateQueue: nil)
            return session
        }
    }
    public init(urlProtocol: URLProtocol.Type? = nil) {
        self.urlProtocol = urlProtocol
    }
    public func sendRequest<ResponseType: Decodable, ErrorType: Decodable>(
        endpoint: Endpoint,
        dto: HTTPClientDTO = HTTPClientDTO(),
        responseModel: ResponseType.Type = EmptyModelServer.self,
        errorModel: ErrorType.Type = ErrorExampleModelServer.self
    ) async throws -> ResponseType {
        let url = try buildURL(endpoint: endpoint)
        let request = try buildRequest(url: url, endpoint: endpoint)
        self.log(title: "REQUEST", info: request)
        do {
            let (data, response) = try await session.data(for: request)
            guard let response = response as? HTTPURLResponse else {
                throw RequestError(errorType: .noResponse)
            }
            self.log(title: "RESPONSE", info: response)
            self.log(title: "DATA", info: data)
            self.log(title: "DATA ENCODING", info: String(data: data, encoding: .utf8) ?? "")
            switch response.statusCode {
            case 200...299:
                Logger.log("\n----- ✅ Status Code: \(response.statusCode) -----")
                guard let decodedResponse = try? JSONDecoder().decode(responseModel, from: data) else {
                    throw RequestError(errorType: .decode)
                }
                return decodedResponse

            case 401:
                Logger.log("\n----- ❌ Status Code: APIError.clientErrorUnauthorized -----")
                guard let decodedError = try? JSONDecoder().decode(errorModel, from: data) else {
                    throw RequestError(errorType: .unauthorize)
                }
                throw RequestError(errorType: .unauthorize, errorModel: decodedError)

            case 400:
                Logger.log("\n----- ❌ Status Code: APIError.clientErrorUnauthorized -----")
                guard let decodedError = try? JSONDecoder().decode(errorModel, from: data) else {
                    throw RequestError(errorType: .badRequest)
                }
                throw RequestError(errorType: .badRequest, errorModel: decodedError)

            default:
                Logger.log("\n----- ❌  APIError.unknown -----")
                guard let decodedError = try? JSONDecoder().decode(errorModel, from: data) else {
                    throw RequestError(errorType: .unexpectedStatusCode(response.statusCode))
                }
                throw RequestError(errorType: .unexpectedStatusCode(response.statusCode), errorModel: decodedError)
            }
        }
    }
    private func buildURL(endpoint: Endpoint) throws -> URL {
        let urlString = endpoint.domain + endpoint.endpoint
        guard let url = URL(string: urlString) else {
            throw RequestError(errorType: .invalidURL)
        }
        return addQueryParams(toURL: url, queryParams: endpoint.queryParams)
    }
    private func addQueryParams(toURL url: URL, queryParams: [String: Any]?) -> URL {
        guard let queryParams = queryParams, var urlComponents = URLComponents(url: url,
                                                                               resolvingAgainstBaseURL: false) else {
            return url
        }
        var queryItems = [URLQueryItem]()
        for param in queryParams {
            if param.value is [Any] {
                // swiftlint:disable force_cast
                let values = param.value as! [Any]
                // swiftlint:enable force_cast
                for value in values {
                    let item = URLQueryItem(name: param.key, value: "\(value)")
                    queryItems.append(item)
                }
            } else {
                let item = URLQueryItem(name: param.key, value: "\(param.value)")
                queryItems.append(item)
            }
        }
        urlComponents.queryItems = queryItems
        guard let updatedURL = urlComponents.url else {
            return url
        }
        return updatedURL
    }
    private func buildRequest(url: URL, endpoint: Endpoint) throws -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header
        request.httpBody = try self.httpBody(bodyParams: endpoint.body)
        return request
    }
    private func httpBody(bodyParams: [String: Any]?) throws -> Data? {
        if let params = bodyParams {
            let body = try JSONSerialization.data(withJSONObject: params, options: [.prettyPrinted, .sortedKeys])
            return body
        }
        return nil
    }
    // Show logs only if is specified by log.
    private func log(title: String, info: Any) {
        if dto.showLog {
            Logger.log("\n----- 🚦START \(title.uppercased()) 🚦-----")
            Logger.log(info)
            Logger.log("\n----- 🚦END \(title.uppercased()) 🚦 -----")
        }
    }
}

extension HTTPClient: URLSessionDelegate {
    public func urlSession(_ session: URLSession,
                           didReceive challenge: URLAuthenticationChallenge,
                           completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        guard let certificateName = self.dto.certificateName,
              let certificateExtension = self.dto.certificateExtension else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }
        guard let serverTrust = challenge.protectionSpace.serverTrust else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }
        var certificates: [ SecCertificate] = []
        if #available(iOS 15.0, *) {
            guard let certificateChain = SecTrustCopyCertificateChain(serverTrust) as? [SecCertificate] else {
                completionHandler(.cancelAuthenticationChallenge, nil)
                return
            }
            certificates = certificateChain
        } else {
            certificates = (0..<SecTrustGetCertificateCount(serverTrust))
                .compactMap { SecTrustGetCertificateAtIndex(serverTrust, $0) }
        }

        // Políticas SSL para la verificación del nombre de dominio
        let policy = NSMutableArray()
        policy.add(SecPolicyCreateSSL(true, challenge.protectionSpace.host as CFString))
        // validar el certificado del servidor
        let isServerTrusted = SecTrustEvaluateWithError(serverTrust, nil)
        // Datos del certificado local y remoto
        let remoteCertificateData: NSData = SecCertificateCopyData(certificates[0])
        guard let pathToLocalCertificate = Bundle.main.path(forResource: certificateName,
                                                            ofType: certificateExtension),
              let localCertificateData = NSData(contentsOfFile: pathToLocalCertificate) else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }
        // Compara los certificados
        if isServerTrusted && remoteCertificateData.isEqual(to: localCertificateData as Data) {
            let credential = URLCredential(trust: serverTrust)
            completionHandler(.useCredential, credential)
        } else {
            completionHandler(.cancelAuthenticationChallenge, nil)
        }
    }
}
