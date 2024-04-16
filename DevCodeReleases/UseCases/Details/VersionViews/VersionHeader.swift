//
//  VersionHeader.swift
//  DevCodeReleases
//
//  Created by Raul on 16/4/24.
//

import SwiftUI

struct VersionHeader: View {
    let version: VersionModel
    
    var body: some View {
        let xcodeVersionName = Utils().getXcodeVersionName(version: version).key
        HStack {
            Text(version.name ?? "")
                .font(.system(size: 24))
            Text(version.version?.number ?? "")
                .font(.system(size: 22))
                .bold()
            
            Text("\(xcodeVersionName)")
                .font(.system(size: xcodeVersionName == "Release" ? 22 : 18))
                .bold()
                .foregroundColor(xcodeVersionName == "Release" ? .green : nil)
            
            Text("\(Utils().getXcodeVersionName(version: version).value)")
                .font(.system(size: 18))
        }
    }
}
