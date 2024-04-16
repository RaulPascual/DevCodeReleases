//
//  VersionInformation.swift
//  DevCodeReleases
//
//  Created by Raul on 16/4/24.
//

import SwiftUI

struct VersionInformation: View {
    let version: VersionModel
    var body: some View {
        VStack {
            Text(LocalizedKeys.Details.otherInfo)
                .bold()
            HStack {
                VStack {
                    Text("Swift")
                    Image("swiftIcon")
                        .resizable()
                        .frame(width: 35, height: 35)
                    Text(version.compilers?.swift?.last?.number ?? "")
                    Text(version.compilers?.swift?.last?.build ?? "")
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.aliceBlueColor.cornerRadius(10))

                Spacer()

                VStack {
                    Text(LocalizedKeys.Details.requires)
                    Image("macIcon")
                        .resizable()
                        .frame(width: 35, height: 35)
                    Text(version.requires ?? "")
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.aliceBlueColor.cornerRadius(10))
            }
        }
        .padding()
    }
}
