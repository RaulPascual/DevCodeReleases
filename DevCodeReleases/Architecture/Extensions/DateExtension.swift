//
//  DateExtension.swift
//  DevCodeReleases
//
//  Created by Raul on 19/5/24.
//

import Foundation

extension Date {
    /**
       Formats a date given day, month, and year components into a string using the specified date style.
       - Parameters:
          - day: An integer representing the day component of the date.
          - month: An integer representing the month component of the date.
          - year: An integer representing the year component of the date.
          - dateStyle: A `DateFormatter.Style` value specifying the desired date format style.

       - Returns: A formatted date string or an empty string if the date components are invalid.
    */
    static func formatDate(day: Int, month: Int, year: Int, dateStyle: DateFormatter.Style) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = dateStyle
        formatter.locale = Locale.current

        var dateComponents = DateComponents()
        dateComponents.day = day
        dateComponents.month = month
        dateComponents.year = year

        let calendar = Calendar.current
        guard let date = calendar.date(from: dateComponents) else {
            return ""
        }

        return formatter.string(from: date)
    }

    /**
       Creates a `Date` object from individual day, month, and year components.
       - Parameters:
          - day: An integer representing the day component of the date.
          - month: An integer representing the month component of the date.
          - year: An integer representing the year component of the date.

       - Returns: A `Date` object if the components form a valid date, otherwise `nil`.
    */
    static func createDate(day: Int, month: Int, year: Int) -> Date? {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day

        return calendar.date(from: dateComponents)
    }
}
