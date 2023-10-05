//
//  BuildView.swift
//  XcodeReleases
//
//  Created by Raul on 3/6/23.
//

import SwiftUI

struct BuildView: View {
    var version: VersionModel
    var body: some View {
        HStack {
            Image("hammerIcon")
                .resizable()
                .iconStyle()
            
            Text("Build")
            Text("\(version.version?.build ?? "")")
        }
    }
}
