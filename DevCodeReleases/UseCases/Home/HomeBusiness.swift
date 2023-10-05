// 
//  HomeBusiness.swift
//  XcodeReleases
//
//  Created by Raul on 30/5/23.
//

import Foundation

class HomeBusiness: BaseBusiness {
    func getXcodeVersions () async throws -> HomeModelBusiness {
        let provider = HomeProvider()
        
        let modelServer = try await provider.getXcodeList()
        return HomeModelBusiness(modelServer: modelServer)
    }
    
}
