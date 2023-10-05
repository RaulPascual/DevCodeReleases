//
//  XcodeReleasesApp.swift
//  XcodeReleases
//
//  Created by Raul on 26/5/23.
//

import SwiftUI

@main
struct DevCodeReleasesApp: App {
    @AppStorage("onboardingViewed") var onboardingViewed = false
    var body: some Scene {
        WindowGroup {
            if onboardingViewed {
                HomeView()
            } else {
                OnboardingView()
            }
        }
    }
}
