//
//  VersionClang.swift
//  DevCodeReleases
//
//  Created by Raul on 16/4/24.
//

import SwiftUI

struct VersionClang: View {
    let version: VersionModel

    var body: some View {
        VStack {
            Text("Clang")
                .bold()
            VStack(alignment: .leading) {
                HStack {
                    VStack {
                        HStack {
                            Text(version.compilers?.clang?.last?.number ?? "")
                                .multilineTextAlignment(.leading)
                                .bold()
                        }

                        HStack {
                            Image("hammerIcon")
                                .resizable()
                                .frame(width: 35, height: 35)
                            Text(version.compilers?.clang?.last?.build ?? "")
                                .bold()
                                .multilineTextAlignment(.leading)
                                .padding()
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.aliceBlueColor.cornerRadius(10))
                }
            }
        }
        .padding()
    }
}
