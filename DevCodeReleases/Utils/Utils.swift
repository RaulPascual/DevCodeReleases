//
//  Utils.swift
//  XcodeReleases
//
//  Created by Raul on 2/6/23.
//

import Foundation

struct Utils {
    func formatDate(day: Int, month: Int, year: Int, dateStyle: DateFormatter.Style) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = dateStyle
        formatter.locale = Locale.current
        
        guard let date = createDate(day: day, month: month, year: year) else {
            return ""
        }
        
        return formatter.string(from: date)
    }
    
    func createDate(day: Int, month: Int, year: Int) -> Date? {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        
        return calendar.date(from: dateComponents)
    }
    
    func getXcodeVersionName(version: VersionModel) -> (key: String, value: String) {
        if version.version?.release?.beta != nil {
            return ("Beta", "\(version.version?.release?.beta ?? 0)")
        }
        
        if version.version?.release?.release == true {
            return ("Release", "")
        }
        
        if version.version?.release?.rc ?? 0 > 0 {
            return ("Release Candidate", "\(version.version?.release?.rc ?? 0)")
        }
        
        return ("","")
    }

    func updateUserDefaultsArray(withValue value: Any, forKey key: String) {
        let defaults = UserDefaults.standard
        
        if var existingArray = defaults.array(forKey: key) {
            existingArray.append(value)
            defaults.set(existingArray, forKey: key)
            defaults.synchronize()
        } else {
            let newArray = [value]
            defaults.set(newArray, forKey: key)
            defaults.synchronize()
        }
        defaults.synchronize()
    }
    
    func getUserDefaultsArrayValues(forKey key: String) -> [String]? {
        let defaults = UserDefaults.standard
        return defaults.array(forKey: key) as? [String]
        
    }

    func checkValueInUserDefaultsArray(value: String, forKey key: String) -> Bool {
        let defaults = UserDefaults.standard
        
        if let array = defaults.array(forKey: key) as? [String] {
            return array.contains(value)
        }
        return false
    }
    
    func removeValueFromUserDefaultsArray(value: String, forKey key: String) {
        let defaults = UserDefaults.standard
        
        if var array = defaults.array(forKey: key) as? [String] {
            if let index = array.firstIndex(of: value) {
                array.remove(at: index)
                defaults.set(array, forKey: key)
                defaults.synchronize()
            }
        }
    }
    
    func getVersionID(version: VersionModel) -> String {
        let day = String(version.date?.day ?? 0)
        let month = String(version.date?.month ?? 0)
        let year = String(version.date?.year ?? 0)
        let checksum = version.checksums?.sha1 ?? ""
        return checksum + day + month + year 
        
    }

}
