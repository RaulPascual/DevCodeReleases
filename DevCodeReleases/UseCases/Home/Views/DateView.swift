//
//  DateView.swift
//  XcodeReleases
//
//  Created by Raul on 2/6/23.
//

import SwiftUI

struct DateView: View {
    var version: VersionModel
    var dateStyle: DateFormatter.Style
    var body: some View {
        // Date
        HStack {
            Image("calendarIcon")
                .resizable()
                .iconStyle()
            
            Text(Utils().formatDate(day: version.date?.day ?? 0,
                                    month: version.date?.month ?? 0,
                                    year: version.date?.year ?? 0,
                                    dateStyle: dateStyle))
        }
    }
}
