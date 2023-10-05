//
//  HomeViewModel.swift
//  XcodeReleases
//
//  Created by Raul on 30/5/23.
//

import Foundation
import Observation

extension HomeView {
    @Observable @MainActor  class HomeViewModel: BaseViewModel {
        var business = HomeBusiness()
        var modelView = HomeModelView(modelBusiness: nil)
        var resultList: [VersionModel] = []
        var selectedOption = "All"
        let options = ["All", "Beta", "Release"]
        
        func onAppear() async {
            await self.getXcodeVersions()
        }
        
        private func getXcodeVersions() async {
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
                print("Error \(error)")
            }
        }
        
        public func filterSearchText(searchText: String) {
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
        
        public func changePickerValue(newPickerValue: String) {
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
    }
}
