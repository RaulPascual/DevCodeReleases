// 
//  HomeModelBusiness.swift
//  XcodeReleases
//
//  Created by Raul on 30/5/23.
//

import Foundation

class HomeModelBusiness {
    // Define properties
    var versions: [VersionModel] = []

    init(modelServer: HomeModelServer?) {
        modelServer?.forEach({ version in
            versions.append(version)
        })
    }
}
