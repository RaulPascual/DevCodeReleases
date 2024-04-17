//
//  HomeProvider.swift
//  XcodeReleases
//
//  Created by Raul on 1/6/23.
//

import Foundation

class HomeProvider: BaseProvider {
    func getXcodeList() async throws -> HomeModelServer {
        return try await modelNetwork.sendRequest(
            endpoint: XcodeVersion.currentVersions,
            responseModel: HomeModelServer.self,
            errorModel: ErrorExampleModelServer.self)
    }
}

public struct ErrorExampleModelServer: Codable {
    let codeError: Int?
}

public struct EmptyModelServer: Codable {
}
