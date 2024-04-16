//
//  FavouritesView.swift
//  DevCodeReleases
//
//  Created by Raul on 13/6/23.
//

import SwiftUI

struct FavouritesView: View {
    var viewModel = FavouritesViewModel()
    var allVersions: [VersionModel]
    @State var favourites: [String] = (Utils().getUserDefaultsArrayValues(forKey: "favourites") ?? [])
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.favouritesVersions.isEmpty {
                    Spacer()
                    Group {
                        Text(LocalizedKeys.Favourites.favouritesEmpty)
                            .customFont(size: 20)
                            
                        
                        Text(LocalizedKeys.Favourites.favouritesInstructions)
                            .customFont(size: 18)
                            
                        Image("emptyStateIcon")
                            .resizable()
                            .frame(width: 200, height: 200)
                    }
                    .padding()
                    Spacer()
                } else {
                    List {
                        ForEach(viewModel.favouritesVersions, id: \.self) { version in
                            if viewModel.favouritesVersionsID.contains(Utils().getVersionID(version: version)) {
                                NavigationLink(destination: {
                                    DetailsView(version: version)
                                }, label: {
                                    VStack(alignment: .leading) {
                                        VersionView(version: version)
                                        HStack {
                                            DateView(version: version, dateStyle: .medium)
                                            Spacer()
                                            BuildView(version: version)
                                        }
                                        SystemsVersions(version: version, extendedView: false)
                                    }
                                })
                                .swipeActions {
                                    Button {
                                        Utils().removeValueFromUserDefaultsArray(value: Utils().getVersionID(version: version),
                                                                                 forKey: "favourites")
                                        self.favourites = Utils().getUserDefaultsArrayValues(forKey: "favourites") ?? []
                                    } label: {
                                        Image(systemName: "trash.fill")
                                    }
                                    .tint(.red)
                                    .onChange(of: self.favourites, { _, _ in
                                        self.favourites = Utils().getUserDefaultsArrayValues(forKey: "favourites") ?? []
                                        viewModel.onAppear(allVersions: allVersions)
                                    })
                                }
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle(LocalizedKeys.Favourites.favouritesTitle)
        .listStyle(.plain)
        .onAppear {
            self.viewModel.onAppear(allVersions: allVersions)
        }
    }
}
