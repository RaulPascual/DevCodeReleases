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
        let xcodeVersionName = Utils().getXcodeVersionName(version: version).key
        GeometryReader { proxy in
            VStack {
                // MARK: - Header - Xcode version name
                HStack {
                    Text(version.name ?? "")
                        .font(.system(size: 24))
                    Text(version.version?.number ?? "")
                        .font(.system(size: 22))
                        .bold()
                    
                    
                    Text("\(xcodeVersionName)")
                        .font(.system(size: xcodeVersionName == "Release" ? 22 : 18))
                        .bold()
                        .foregroundColor(xcodeVersionName == "Release" ? .green : nil)
                    
                    Text("\(Utils().getXcodeVersionName(version: version).value)")
                        .font(.system(size: 18))
                }
                
                ScrollView {
                    // MARK: - Publication date
                    HStack {
                        VStack {
                            Text(LocalizedKeys.Details.releaseDate)
                            Image("calendarIcon")
                                .resizable()
                                .frame(width: 35, height: 35)
                            Text(Utils().formatDate(day: version.date?.day ?? 0,
                                                    month: version.date?.month ?? 0,
                                                    year: version.date?.year ?? 0,
                                                    dateStyle: .medium))
                        }
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.aliceBlueColor.cornerRadius(10))
                        
                        Spacer()
                    
                        // MARK: - Build number
                        VStack {
                            Text("Build")
                            Image("hammerIcon")
                                .resizable()
                                .frame(width: 35, height: 35)
                            Text("\(version.version?.build ?? "")")
                        }
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.aliceBlueColor.cornerRadius(10))
                        
                    }
                    .padding()
                    
                    // MARK: - SDKs versions
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
                    
                    // MARK: - Other information like Swift version and minimum requirements
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
                    
                    // MARK: - Checksum
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
                    
                    // MARK: - Clang
                    VStack {
                        Text("Clang")
                            .bold()
                        VStack(alignment: .leading) {
                            HStack {
                                VStack() {
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
                    
                    // MARK: - Release notes webview
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
                    Spacer()
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

