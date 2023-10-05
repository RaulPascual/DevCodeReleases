// 
//  HomeView.swift
//  XcodeReleases
//
//  Created by Raul on 30/5/23.
//

import SwiftUI

struct HomeView: View {
    @State var viewModel = HomeViewModel()
    @Environment(\.colorScheme) var colorScheme
    @State private var showMenu: Bool = false
    @State private var searchText = ""
    @State var favourites: [String] = (Utils().getUserDefaultsArrayValues(forKey: "favourites") ?? [])
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(alignment: .leading) {
                    TextFieldSearcher(searchText: $searchText)
                    
                    Picker("", selection: $viewModel.selectedOption) {
                        ForEach(viewModel.options, id: \.self) { option in
                            Text(option)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding()
                    .onChange(of: viewModel.selectedOption) { _, newPickerValue in
                        self.searchText = ""
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
                                    if isFavourite(version: Utils().getVersionID(version: version)) {
                                        Utils().removeValueFromUserDefaultsArray(value: Utils().getVersionID(version: version),
                                                                                 forKey: "favourites")
                                        self.favourites = Utils().getUserDefaultsArrayValues(forKey: "favourites") ?? []
                                        print(self.favourites)
                                    } else {
                                        Utils().updateUserDefaultsArray(withValue: Utils().getVersionID(version: version),
                                                                        forKey: "favourites")
                                        self.favourites = Utils().getUserDefaultsArrayValues(forKey: "favourites") ?? []
                                        print(self.favourites)
                                    }
                                } label: {
                                    Image(systemName: self.isFavourite(version: Utils().getVersionID(version: version)) ?
                                          "trash.fill" : "star.fill")
                                }
                                .tint(self.isFavourite(version: Utils().getVersionID(version: version)) ? .red : .yellow)
                                .onChange(of: self.favourites) { _, _ in
                                        self.favourites = Utils().getUserDefaultsArrayValues(forKey: "favourites") ?? []
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
                            .offset(x: showMenu ? 0 : -UIScreen.main.bounds.width) // put - if left, + if right
                            .animation(.easeInOut(duration: 0.4), value: showMenu)
                        Spacer() // to left
                    }
                    
                }
                .background(Color.black.opacity(showMenu ? 0.5 : 0))
            }
            .toolbar {
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                    HStack {
                        Button {
                            self.showMenu.toggle()
                        } label: {
                            SideMenuButtonView(showMenu: showMenu)
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
            self.favourites = []
            self.favourites = Utils().getUserDefaultsArrayValues(forKey: "favourites") ?? []
        }
        .onChange(of: self.searchText, { _, _ in
            self.viewModel.filterSearchText(searchText: searchText)
        })
        .loaderBase(state: self.viewModel.state)
    }
    
    private func isFavourite(version: String) -> Bool {
        return Utils().checkValueInUserDefaultsArray(value: version,
                                                     forKey: "favourites")
    }
    
    private func updateLocal() {
        
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
