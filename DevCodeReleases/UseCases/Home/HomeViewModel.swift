//
//  HomeViewModel.swift
//  XcodeReleases
//
//  Created by Raul on 30/5/23.
//

import Foundation
import Observation

extension HomeView {
    @Observable @MainActor class HomeViewModel: BaseViewModel {
        var business = HomeBusiness()
        var modelView = HomeModelView(modelBusiness: nil)
        var resultList: [VersionModel] = []
        var selectedOption = "All"
        let options = ["All", "Beta", "Release"]
        var showMenu = false
        var searchText = ""
        var favourites: [String] = (Utils().getUserDefaultsArrayValues(forKey: "favourites") ?? [])

        func onAppear() async {
            await self.getXcodeVersions()
        }

        func getXcodeVersions() async {
            self.state = .loading
            do {
                let modelBusiness = try await business.getXcodeVersions()
                self.modelView = HomeModelView(modelBusiness: modelBusiness)
                self.resultList = self.modelView.versions
                if modelView.versions.isEmpty {
                    Task {
                        await self.onAppear()
                    }
                }
                self.state = .okey
            } catch let error {
                self.state = .error
                Task {
                    await self.onAppear()
                }
                
                Logger.log("Error \(error)")
            }
            
            // Widget
            self.saveStructToUserDefaults(modelView.versions.last, forKey: "lastVersion", suiteName: "group.devcodereleases")
        }
        
        func saveStructToUserDefaults<T: Codable>(_ value: T, forKey key: String, suiteName: String? = nil) {
                let encoder = JSONEncoder()

                if let encoded = try? encoder.encode(value) {
                    let userDefaults: UserDefaults
                    if let suiteName = suiteName {
                        userDefaults = UserDefaults(suiteName: suiteName) ?? UserDefaults.standard
                    } else {
                        userDefaults = UserDefaults.standard
                    }
                    userDefaults.set(encoded, forKey: key)
                }
            }

        func filterSearchText(searchText: String) {
            if searchText.isEmpty {
                self.resultList = modelView.versions
            } else {
                self.selectedOption = "All"
                let filteredVersions = modelView.versions.filter { version in
                    if let versionNumber = version.version?.number {
                        let range = versionNumber.range(of: searchText, options: .caseInsensitive)
                        return range != nil
                    }
                    return false
                }
                self.resultList = filteredVersions
            }
        }

        func changePickerValue(newPickerValue: String) {
            self.searchText = ""
            if newPickerValue == "All" {
                resultList = modelView.versions
            } else if newPickerValue == "Beta" {
                let filteredVersions = modelView.versions.filter { version in
                    version.version?.release?.beta != nil
                }
                resultList = filteredVersions
            } else if newPickerValue == "Release" {
                let filteredVersions = modelView.versions.filter { version in
                    version.version?.release?.release == true
                }
                resultList = filteredVersions
            }
        }

        func isFavourite(version: String) -> Bool {
            return Utils().checkValueInUserDefaultsArray(value: version,
                                                         forKey: "favourites")
        }

        func removeFavoriteVersion(version: VersionModel) {
            Utils().removeValueFromUserDefaultsArray(value: Utils().getVersionID(version: version),
                                                     forKey: "favourites")
            self.favourites = Utils().getUserDefaultsArrayValues(forKey: "favourites") ?? []
        }

        func addFavoriteVersion(version: VersionModel) {
            Utils().updateUserDefaultsArray(withValue: Utils().getVersionID(version: version),
                                            forKey: "favourites")
            self.favourites = Utils().getUserDefaultsArrayValues(forKey: "favourites") ?? []
        }

        func updateFavoriteVersions() {
            self.favourites = []
            self.favourites = Utils().getUserDefaultsArrayValues(forKey: "favourites") ?? []
        }
    }
}
