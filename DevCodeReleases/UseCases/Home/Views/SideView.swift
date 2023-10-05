//
//  SideView.swift
//  DevCodeReleases
//
//  Created by Raul on 6/6/23.
//


import SwiftUI

struct SideMenuView: View {

    @State var isAboutSheetPresented = false
    var allVersions: [VersionModel]

    var body: some View {
        Group {
            GeometryReader { geometry in
                VStack(alignment: .leading) {
                    Text(LocalizedKeys.Details.sidemenuMenu)
                        .font(.title)
                    Rectangle()
                        .frame(height: 2)
                        .padding(.init(top: 4, leading: 0, bottom: 4, trailing: 16))
                    
                    Group {
                        VStack(alignment: .leading){
                            NavigationLink {
                                AboutSymbologyView()
                            } label: {
                                HStack {
                                    Image(systemName: "questionmark.circle.fill")
                                        .foregroundColor(.yellow)
                                        .padding(.trailing, 10)
                                    Text(LocalizedKeys.Details.sidemenuAboutSymbols)
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundColor(Color.textColor)
                                }
                                .padding()
                            }
                            
                            NavigationLink {
                                DifferencesView()
                            } label: {
                                HStack {
                                    Image(systemName: "questionmark.circle.fill")
                                        .foregroundColor(.yellow)
                                        .padding(.trailing, 10)
                                    Text(LocalizedKeys.Menu.differencesMenu)
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundColor(Color.textColor)
                                        .multilineTextAlignment(.leading)
                                }
                                .padding()
                            }
                            
                            NavigationLink {
                                FavouritesView(allVersions: allVersions)
                            } label: {
                                HStack {
                                    Image(systemName: "questionmark.circle.fill")
                                        .foregroundColor(.yellow)
                                        .padding(.trailing, 10)
                                    Text(LocalizedKeys.Favourites.favouritesTitle)
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundColor(Color.textColor)
                                        .multilineTextAlignment(.leading)
                                }
                                .padding()
                            }
                            
                        }
                        .padding(.bottom, 16)
                        Spacer()
                    }
                }
                .padding(.leading, 10)
                .frame(maxWidth: geometry.size.width * 0.90, maxHeight: .infinity, alignment: .leading)
                .background(Color.aliceBlueColor)
                .sheet(isPresented: self.$isAboutSheetPresented) {
                    Group {
                        Text("Application made by Raul Pascual")
                        Text("Icons provided by iconos8.es")
                    }
                    .padding()
                    .presentationDetents([.medium, .fraction(0.4)])
                }
            }
        }
    }
}
