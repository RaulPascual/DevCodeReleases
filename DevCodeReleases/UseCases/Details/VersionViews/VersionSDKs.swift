//
//  VersionSDKs.swift
//  DevCodeReleases
//
//  Created by Raul on 16/4/24.
//

import SwiftUI

struct VersionSDKs: View {
    let version: VersionModel
    var body: some View {
        VStack {
            Text("SDKs")
                .bold()

            VStack {
                SystemsVersions(version: version, extendedView: true)
            }
            .padding()
            .background(Color.aliceBlueColor.cornerRadius(10))
        }
        .padding()
    }
}
