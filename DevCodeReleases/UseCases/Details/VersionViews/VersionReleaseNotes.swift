//
//  VersionReleaseNotes.swift
//  DevCodeReleases
//
//  Created by Raul on 16/4/24.
//

import SwiftUI

struct VersionReleaseNotes: View {
    let version: VersionModel
    let proxy: GeometryProxy
    @Binding var showWebView: Bool

    var body: some View {
        VStack {
            Button {
                if let notesURLString = version.links?.notes?.url, let notesURL = URL(string: notesURLString) {
                    if UIApplication.shared.canOpenURL(notesURL) {
                        self.showWebView = true
                    }
                }
            } label: {
                Text(LocalizedKeys.Details.realeaseNotesButton)
                    .font(.system(size: 22))
            }
            .sheet(isPresented: $showWebView) {
                WebView(url: version.links?.notes?.url ?? "apple.com")
                    .presentationDetents([.height(proxy.size.height * 0.90), .large])
                    .presentationDragIndicator(.automatic)
            }
        }
    }
}
