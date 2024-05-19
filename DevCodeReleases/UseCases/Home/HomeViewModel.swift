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
        
        /**
         Fetches Xcode versions asynchronously and updates the state accordingly.
         - Note: This function sets the state to `.loading` before fetching the Xcode versions.
         If successful, it updates the `modelView` and `resultList` with the fetched versions, sets the state to `.okey`, and saves the first version 
         to UserDefaults with the specified suiteName.
         If an error occurs during fetching, it logs the error and retries fetching onAppear after a delay.
         */
        
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
                retryOnAppearAfterDelay()
                Logger.log("Error \(error)")
            }
            
            // Widget
            self.saveStructToUserDefaults(modelView.versions.first, forKey: "lastVersion", suiteName: "group.devcodereleases")
        }
        
        /**
         Retries fetching Xcode versions after a delay.
         - Note: This function sets the state to `.error` and schedules a task to call `getXcodeVersions` after a 5-second delay.
         */
        func retryOnAppearAfterDelay() {
            self.state = .error
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
                Task {
                    await self?.getXcodeVersions()
                }
            }
        }
        
        /**
         Saves a Codable struct to `UserDefaults`.
         - Parameters:
         - value: The struct conforming to `Codable` to be saved.
         - key: A string key to identify the saved data.
         - suiteName: An optional string for the suite name to use with `UserDefaults`. If `nil`, the standard `UserDefaults` is used.
         
         - Note: This function uses `JSONEncoder` to encode the struct and saves the encoded data to `UserDefaults`.
         */
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
        
        /**
         Filters the list of versions based on the provided search text.
         - Parameters:
         - searchText: A string containing the text to search for in the version numbers.
         
         - Note: If `searchText` is empty, the result list is set to the full list of versions. Otherwise, it filters the versions whose numbers
         contain the search text (case-insensitive) and sets the selected option to "All".
         */
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
        
        /**
         Updates the result list based on the new picker value.
         - Parameters:
         - newPickerValue: A string representing the selected picker value. It can be "All", "Beta", or "Release".
         
         - Note: If the new picker value is "All", the result list is set to the full list of versions. If "Beta" or "Release",
         it filters the versions accordingly.
         */
        func changePickerValue(newPickerValue: String) {
            self.searchText = ""
            switch newPickerValue {
            case "All":
                resultList = modelView.versions
            case "Beta":
                resultList = modelView.versions.filter { $0.version?.release?.beta != nil }
            case "Release":
                resultList = modelView.versions.filter { $0.version?.release?.release == true }
                
            default:
                resultList = modelView.versions
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
