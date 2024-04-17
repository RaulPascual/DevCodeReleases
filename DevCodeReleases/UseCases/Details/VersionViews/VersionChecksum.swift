//
//  VersionChecksum.swift
//  DevCodeReleases
//
//  Created by Raul on 16/4/24.
//

import SwiftUI

struct VersionChecksum: View {
    let version: VersionModel

    var body: some View {
        VStack {
            Text("Checksum")
                .bold()
            HStack {
                VStack {
                    Text(version.checksums?.sha1 ?? "")
                        .multilineTextAlignment(.leading)
                        .padding()
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.aliceBlueColor.cornerRadius(10))
            }
        }
        .padding()
    }
}
