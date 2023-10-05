// 
//  OnboardingView.swift
//  DevCodeReleases
//
//  Created by Raul on 17/6/23.
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage("onboardingViewed") var onboardingViewed: Bool?
    var body: some View {
        VStack {
            TabView {
                OnBoardView(image: "onboarding1Icon",
                            title: LocalizedKeys.Onboarding.onboardingTitle1.stringValue(),
                            description: LocalizedKeys.Onboarding.onboardingSubtitle1.stringValue())

                OnBoardView(image: "onboarding2Icon",
                            title: LocalizedKeys.Onboarding.onboardingTitle2.stringValue(),
                            description: LocalizedKeys.Onboarding.onboardingSubtitle2.stringValue())

                OnBoardView(image: "onboarding3Icon",
                            title: LocalizedKeys.Onboarding.onboardingTitle3.stringValue(),
                            description: LocalizedKeys.Onboarding.onboardingSubtitle3.stringValue(),
                comingSoon: true)
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .indexViewStyle(.page(backgroundDisplayMode: .always))

            HStack {
                Spacer()
                Button {
                    self.onboardingViewed = true
                } label: {
                    Image(systemName: "arrow.right.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                }
                .padding(.init(top: 20, leading: 50, bottom: 20, trailing: 30))
            }
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing))
    }
}

struct OnBoardView: View {
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

#Preview {
    OnboardingView()
}
