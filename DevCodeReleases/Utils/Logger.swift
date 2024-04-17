//
//  Logger.swift
//  DevCodeReleases
//
//  Created by Raul on 16/4/24.
//

import Foundation

// swiftlint: disable disable_print
enum Logger {
    static func log(_ items: Any...) {
#if targetEnvironment(simulator)
        print(items)
#endif
    }
}
// swiftlint: enable disable_print
