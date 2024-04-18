// 
//  HomeView.swift
//  XcodeReleases
//
//  Created by Raul on 30/5/23.
//

import SwiftUI
import WidgetKit

struct HomeView: View {
    @State var viewModel = HomeViewModel()
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        NavigationStack {
            ZStack {
                VStack(alignment: .leading) {
                    TextFieldSearcher(searchText: $viewModel.searchText)

                    Picker("", selection: $viewModel.selectedOption) {
                        ForEach(viewModel.options, id: \.self) { option in
                            Text(option)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding()
                    .onChange(of: viewModel.selectedOption) { _, newPickerValue in
                        viewModel.changePickerValue(newPickerValue: newPickerValue)
                    }

                    List {
                        ForEach(viewModel.resultList, id: \.self) { version in
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
                                    if self.viewModel.isFavourite(version: Utils().getVersionID(version: version)) {
                                        self.viewModel.removeFavoriteVersion(version: version)
                                    } else {
                                        self.viewModel.addFavoriteVersion(version: version)
                                    }
                                } label: {
                                    Image(systemName: self.viewModel.isFavourite(version: Utils().getVersionID(version: version)) ?
                                          "trash.fill" : "star.fill")
                                }
                                .tint(self.viewModel.isFavourite(version: Utils().getVersionID(version: version)) ? .red : .yellow)
                                .onChange(of: self.viewModel.favourites) { _, _ in
                                    self.viewModel.favourites = Utils().getUserDefaultsArrayValues(forKey: "favourites") ?? []
                                }
                            }
                        }
                    }
                }
                .navigationDestination(for: VersionModel.self) { version in
                    DetailsView(version: version)
                }
                .navigationTitle("Xcode Releases")
                .listStyle(.plain)

                GeometryReader { _ in
                    HStack {
                        SideMenuView(allVersions: viewModel.modelView.versions)
                            .offset(x: viewModel.showMenu ? 0 : -UIScreen.main.bounds.width) // put - if left, + if right
                            .animation(.easeInOut(duration: 0.4), value: viewModel.showMenu)
                        Spacer() // to left
                    }
                }
                .background(Color.black.opacity(viewModel.showMenu ? 0.5 : 0))
            }
            .toolbar {
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                    HStack {
                        Button {
                            self.viewModel.showMenu.toggle()
                        } label: {
                            SideMenuButtonView(showMenu: viewModel.showMenu)
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            Task {
                await self.viewModel.onAppear()
            }
            self.viewModel.updateFavoriteVersions()
            WidgetCenter.shared.reloadAllTimelines()
        }
        .onChange(of: self.viewModel.searchText, { _, _ in
            self.viewModel.filterSearchText(searchText: viewModel.searchText)
        })
        .loaderBase(state: self.viewModel.state)
    }
}

// MARK: - The menu images
struct SideMenuButtonView: View {
    var showMenu: Bool
    var body: some View {
        if showMenu {
            Image(systemName: "xmark") // Close Image
                .foregroundColor(.blue)
        } else {
            Image(systemName: "text.justify") // Hamburguer Image
                .foregroundColor(.blue)
        }
    }
}

#Preview {
    HomeView()
}
