//
//  StringExtension.swift
//  DevCodeReleases
//
//  Created by Raul on 8/6/23.
//

import SwiftUI

extension String {
    static func localizedString(for key: String,
                                locale: Locale = .current) -> String {
        let language = locale.language.languageCode?.identifier
        guard let path = Bundle.main.path(forResource: language, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            return NSLocalizedString(key, comment: "")
        }

        let localizedString = NSLocalizedString(key, bundle: bundle, comment: "")
        return localizedString
    }
}

extension LocalizedStringKey {
    var stringKey: String {
        let description = "\(self)"

        let components = description.components(separatedBy: "key: \"")
            .map { $0.components(separatedBy: "\",") }

        return components[1][0]
    }

    func stringValue(locale: Locale = .current) -> String {
        return .localizedString(for: self.stringKey, locale: locale)
    }
}
