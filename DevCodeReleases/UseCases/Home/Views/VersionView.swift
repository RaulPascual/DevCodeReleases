//
//  VersionView.swift
//  XcodeReleases
//
//  Created by Raul on 2/6/23.
//

import SwiftUI

struct VersionView: View {
    var version: VersionModel
    var body: some View {
        HStack {
            // Text("Xcode")
            Image("xcodeIcon")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
            Text(version.version?.number ?? "")
                .bold()
            
            if version.version?.release?.beta != nil {
                HStack {
                    Text("Beta")
                    Text("\(version.version?.release?.beta ?? 0)")
                }
            }
            
            if version.version?.release?.release ?? false {
                HStack {
                    if version.version?.release?.release ?? false {
                        Text("Release")
                            .foregroundColor(.green)
                            .bold()
                    }
                }
            }
            
            if version.version?.release?.rc ?? 0 > 0 {
                HStack {
                    Text("Release Candidate \(version.version?.release?.rc ?? 0)")
                }
            }
        }
    }
}
