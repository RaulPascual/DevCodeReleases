//
//  OnboardViewSection.swift
//  DevCodeReleases
//
//  Created by Raul on 16/4/24.
//

import SwiftUI

struct OnBoardViewSection: View {
    var image: String
    var title: String
    var description: String
    var comingSoon: Bool? = false

    var body: some View {
        VStack(spacing: 30) {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.teal)
            Text(title)
                .font(.title).bold()
            Text(description)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .bold()
        }
        .padding(.horizontal)
    }
}
