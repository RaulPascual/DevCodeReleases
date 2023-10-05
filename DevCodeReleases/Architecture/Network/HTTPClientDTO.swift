//
//  HTTPClientDTO.swift
//  XcodeReleases
//
//  Created by Raul on 1/6/23.
//

import Foundation

public struct HTTPClientDTO {
    let timeout: TimeInterval
    let retry: Int
    let showLog: Bool
    let certificateName: String?
    let certificateExtension: String?
    public init(timeout: TimeInterval = 60,
                retry: Int = 0,
                showLog: Bool = true,
                certificateName: String? = nil,
                certificateExtension: String? = nil) {
        self.timeout = timeout
        self.retry = retry
        self.showLog = showLog
        self.certificateName = certificateName
        self.certificateExtension = certificateExtension
    }
}
