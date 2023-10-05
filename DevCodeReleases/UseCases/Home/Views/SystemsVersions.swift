//
//  SystemsVersions.swift
//  XcodeReleases
//
//  Created by Raul on 3/6/23.
//

import SwiftUI

struct SystemsVersions: View {
    var version: VersionModel
    var extendedView: Bool
    var body: some View {
        VStack {
            
            // MARK: - First line (iOS and macOS)
            HStack {
                Image("iosIcon")
                    .resizable()
                    .iconStyle()
                
                if extendedView {
                    Text("iOS")
                }
                Text("\(version.sdks?.iOS?.last?.number ?? "")")
                    .bold(extendedView)
                    
                Spacer()
                
                Image("macIcon")
                    .resizable()
                    .iconStyle()
                
                if extendedView {
                    Text("macOS")
                }
                Text("\(version.sdks?.macOS?.last?.number ?? "")")
                    .bold(extendedView)
            }
            .padding(.bottom, extendedView ? 16 : 4)
            
            // MARK: - Second line (tvOS and watchOS)
            HStack {
                Image("appleTVIcon")
                    .resizable()
                    .iconStyle()
                if extendedView {
                    Text("tvOS")
                }
                Text("\(version.sdks?.tvOS?.last?.number ?? "")")
                    .bold(extendedView)
                
                Spacer()
                
                Image("watchOSIcon")
                    .resizable()
                    .iconStyle()
                if extendedView {
                    Text("watchOS")
                }
                Text("\(version.sdks?.watchOS?.last?.number ?? "")")
                    .bold(extendedView)
            }
            .padding(.bottom, extendedView ? 16 : 4)
        }
        .padding(.trailing, 40)
    }
}
