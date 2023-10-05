//
//  StringExtension.swift
//  DevCodeReleases
//
//  Created by Raul on 8/6/23.
//

import SwiftUI

extension String {
    func getCurrentDate() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }

    func getCurrentDateWithHour() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: date)
    }

    func pastDate(years: Int, months: Int, days: Int) -> String {
        let monthsToAdd = -2
        let daysToAdd = 0
        let yearsToAdd = 0
        let currentDate = Date()
        var dateComponent = DateComponents()

        dateComponent.month = monthsToAdd
        dateComponent.day = daysToAdd
        dateComponent.year = yearsToAdd

        guard let futureDate = Calendar.current.date(byAdding: dateComponent, to: currentDate) else {
            return ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: futureDate)
    }

    static func localizedString(for key: String,
                                locale: Locale = .current) -> String {
        let language = locale.language.languageCode?.identifier
        let path = Bundle.main.path(forResource: language, ofType: "lproj")!
        let bundle = Bundle(path: path)!
        let localizedString = NSLocalizedString(key, bundle: bundle, comment: "")

        return localizedString
    }

    func replaceLocalized(id: String, value: String) -> String {
        return self.replacingOccurrences(of: "·\(id)·", with: value)
    }

    func replaceMarkdown() -> String {
        return self.replacingOccurrences(of: "·", with: "**")
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
