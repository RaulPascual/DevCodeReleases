//
//  DevCodeReleasesTests.swift
//  DevCodeReleasesTests
//
//  Created by Raul on 17/4/24.
//

import XCTest
@testable import DevCodeReleases

final class DevCodeReleasesTests: XCTestCase {

    var sut: HomeView.HomeViewModel!
    override func setUpWithError() throws {
        print(#function, "setUp func")
        sut = HomeView.HomeViewModel()
    }

    override func tearDownWithError() throws {
        print(#function, "tearDown func")
        if testRun?.failureCount ?? 0 > 0 {
            print("\(testRun?.test.name ?? "ErrorTestName") failed with a duration of \(testRun?.testDuration ?? 00)")
        } else {
            print("\(testRun?.test.name ?? "ErrorTestName") passed with a duration of \(testRun?.testDuration ?? 00)")
        }
        sut = nil
    }

    @MainActor
    func testGetXcodeVersions() async {
       await sut.getXcodeVersions()
        XCTAssertNotEqual(sut.state, .loading)
        XCTAssertFalse(sut.modelView.versions.isEmpty)
    }

    @MainActor
    func testFilterSearchText() async {
        let textToSearch = "15.4"
        let emptyTextToSearch = "RandomText"

        await sut.getXcodeVersions()

        sut.filterSearchText(searchText: textToSearch)
        XCTAssertTrue(sut.resultList.count < sut.modelView.versions.count)

        sut.filterSearchText(searchText: emptyTextToSearch)
        XCTAssertTrue(sut.resultList.count == 0)
    }

    @MainActor
    func testChangePickerValue() async {
        await sut.getXcodeVersions()

        // Release versions
        var pickerValue = "Release"
        sut.changePickerValue(newPickerValue: pickerValue)
        XCTAssertTrue(sut.resultList.count > 0)
        XCTAssertTrue(sut.resultList.allSatisfy({ version in
            version.version?.release?.release == true
        }))

        // Beta versions
        pickerValue = "Beta"
        sut.changePickerValue(newPickerValue: pickerValue)
        XCTAssertTrue(sut.resultList.count > 0)
        XCTAssertTrue(sut.resultList.allSatisfy({ version in
            version.version?.release?.beta != nil
        }))
    }

    @MainActor
    func testAddFavoriteVersion() async {
        await sut.getXcodeVersions()
        let firstVersionElement = sut.modelView.versions.first
        if let firstVersionElement {
            sut.addFavoriteVersion(version: firstVersionElement)

            let getVersion = Utils().getUserDefaultsArrayValues(forKey: "favouritesTest")
            XCTAssertFalse(((getVersion?.isEmpty) != nil))
            sut.removeFavoriteVersion(version: firstVersionElement)
        }
    }

    @MainActor
    func testRemoveFavoriteVersion() async {
        await sut.getXcodeVersions()
        let firstVersionElement = sut.modelView.versions.first
        if let firstVersionElement {
            sut.addFavoriteVersion(version: firstVersionElement)
            sut.removeFavoriteVersion(version: firstVersionElement)
            let getVersion = Utils().getUserDefaultsArrayValues(forKey: "favouritesTest")

            XCTAssertTrue(getVersion?.isEmpty ?? true)
        }
    }

}
