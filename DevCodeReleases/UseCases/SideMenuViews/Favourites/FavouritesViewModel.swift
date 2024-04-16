// 
//  FavouritesViewModel.swift
//  DevCodeReleases
//
//  Created by Raul on 13/6/23.
//

import Foundation

extension FavouritesView {
    @MainActor @Observable class FavouritesViewModel: BaseViewModel {
        var favouritesVersionsID: [String] = []
        var favouritesVersions: [VersionModel] = []

        func onAppear(allVersions: [VersionModel]) {
            let favourites = Utils().getUserDefaultsArrayValues(forKey: "favourites")
            self.favouritesVersionsID = favourites ?? []

            self.favouritesVersions = allVersions.filter { favouritesVersionsID.contains(Utils().getVersionID(version: $0)) }
        }
    }
}
