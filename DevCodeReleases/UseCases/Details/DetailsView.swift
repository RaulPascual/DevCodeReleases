// 
//  DetailsView.swift
//  XcodeReleases
//
//  Created by Raul on 3/6/23.
//

import SwiftUI

struct DetailsView: View {
    let version: VersionModel
    @State var showWebView = false
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                // MARK: - Header - Xcode version name
                VersionHeader(version: version)
                
                ScrollView {
                    // MARK: - Publication date
                    VersionPublicationDate(version: version)
                    
                    // MARK: - SDKs versions
                    VersionSDKs(version: version)
                    
                    // MARK: - Other information like Swift version and minimum requirements
                    VersionInformation(version: version)
                    
                    // MARK: - Checksum
                   VersionChecksum(version: version)
                    
                    // MARK: - Clang
                    VersionClang(version: version)
                    
                    // MARK: - Release notes webview
                    VersionReleaseNotes(version: version,
                                        proxy: proxy,
                                        showWebView: $showWebView)
                    Spacer()
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
