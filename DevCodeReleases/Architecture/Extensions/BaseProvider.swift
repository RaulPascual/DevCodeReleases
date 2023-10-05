//
//  BaseProvider.swift
//  XcodeReleases
//
//  Created by Raul on 1/6/23.
//

import Foundation

class BaseProvider {
    var baseClientDTO: HTTPClientDTO {
        return HTTPClientDTO(timeout: 55.0,
                             retry: 0,
                             showLog: false,
                             certificateName: certificateName,
                             certificateExtension: certificateExtension)
    }
    var modelNetwork: HTTPClient
    var certificateName: String = "certi"
    var certificateExtension: String = "cer"
    init() {
        self.modelNetwork = HTTPClient()
    }
}
