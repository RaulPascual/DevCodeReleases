//
//  APIError.swift
//  XcodeReleases
//
//  Created by Raul on 1/6/23.
//

import Foundation

public struct RequestError: Error {
    public var errorType: RequestErrorType
    public var errorModel: Decodable?
}

public enum RequestErrorType: Error {
    case decode
    case invalidURL
    case noResponse
    case unauthorize
    case badRequest
    case unexpectedStatusCode(Int)
    case unknown
    var customMessage: String {
        switch self {
        case .decode:
            return "Decode error"

        case .unauthorize:
            return "Session expired"

        case .invalidURL:
            return "Invalid URL"

        case .noResponse:
            return "No Response"

        case .badRequest:
            return "Bad Request"

        case .unexpectedStatusCode:
            return "Unexpected Status Code"

        case .unknown:
            return "Unkwown"
        }
    }
}
