// 
//  HomeModelView.swift
//  XcodeReleases
//
//  Created by Raul on 30/5/23.
//

import Foundation

struct HomeModelView {
    // Define properties
    var versions: [VersionModel] = []
    
    init(modelBusiness: HomeModelBusiness?) {
        self.versions = modelBusiness?.versions ?? []
    }
}
