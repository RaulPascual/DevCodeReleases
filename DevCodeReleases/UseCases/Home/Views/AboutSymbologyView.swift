//
//  AboutSymbologyView.swift
//  DevCodeReleases
//
//  Created by Raul on 6/6/23.
//

import SwiftUI

struct AboutSymbologyView: View {
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView {
               Text(LocalizedKeys.Details.sidemenuIconMean)
                    .font(.system(size: 20))
                    .padding()

                Group {
                    VStack(alignment: .leading) {
                        // Calendar
                        SymbologyView(image: Image("calendarIcon"),
                                      text: Text(LocalizedKeys.Details.iconDate))

                        // Build
                        SymbologyView(image: Image("hammerIcon"),
                                      text: Text(LocalizedKeys.Details.iconBuild))

                        // iOS
                        SymbologyView(image: Image("iosIcon"),
                                      text: Text(LocalizedKeys.Details.iconIos))

                        // macOS
                        SymbologyView(image: Image("macIcon"),
                                      text: Text(LocalizedKeys.Details.iconMac))

                        // tvOS
                        SymbologyView(image: Image("appleTVIcon"),
                                      text: Text(LocalizedKeys.Details.iconTv))

                        // watchOS
                        SymbologyView(image: Image("watchOSIcon"),
                                      text: Text(LocalizedKeys.Details.iconTv))

                        // Swift
                        SymbologyView(image: Image("swiftIcon"),
                                      text: Text(LocalizedKeys.Details.iconSwift))
                    }
                }
                .padding()
            }
        }
        .navigationTitle(LocalizedKeys.Details.sidemenuAboutSymbols.stringValue())
    }
}

struct SymbologyView: View {
    var image: Image
    var text: Text

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                image
                    .resizable()
                    .frame(width: 35, height: 35)
                text
            }
            Divider()
        }
    }
}

#Preview {
    AboutSymbologyView()
}
