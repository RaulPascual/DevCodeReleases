//
//  VersionPublicationDate.swift
//  DevCodeReleases
//
//  Created by Raul on 16/4/24.
//

import SwiftUI

struct VersionPublicationDate: View {
    let version: VersionModel
    var body: some View {
        HStack {
            VStack {
                Text(LocalizedKeys.Details.releaseDate)
                Image("calendarIcon")
                    .resizable()
                    .frame(width: 35, height: 35)
                Text(Utils().formatDate(day: version.date?.day ?? 0,
                                        month: version.date?.month ?? 0,
                                        year: version.date?.year ?? 0,
                                        dateStyle: .medium))
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.aliceBlueColor.cornerRadius(10))
            
            Spacer()
        
            // MARK: - Build number
            VStack {
                Text("Build")
                Image("hammerIcon")
                    .resizable()
                    .frame(width: 35, height: 35)
                Text("\(version.version?.build ?? "")")
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.aliceBlueColor.cornerRadius(10))
            
        }
        .padding()
    }
}

