//
//  Endpoint.swift
//  XcodeReleases
//
//  Created by Raul on 30/5/23.
//

import Foundation

public protocol Endpoint {
    var domain: String { get }
    var endpoint: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: [String: Any]? { get }
    var queryParams: [String: Any]? { get }
}


enum XcodeVersion {
    case currentVersions
}

extension XcodeVersion: Endpoint {
   
    var domain: String {
        return Constants.baseURL
    }
    
    var endpoint: String {
        var path = ""

        path = Constants.path
        return path
    }
    
    var queryParams: [String : Any]? {
        return nil
    }

    var method: RequestMethod { return .get }

    var header: [String: String]? { return ["Content-Type": "application/json"] }
    
    var body: [String : Any]? { return nil }
    
}
