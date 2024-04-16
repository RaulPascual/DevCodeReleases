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
                OnBoardViewSection(image: "onboarding1Icon",
                            title: LocalizedKeys.Onboarding.onboardingTitle1.stringValue(),
                            description: LocalizedKeys.Onboarding.onboardingSubtitle1.stringValue())

                OnBoardViewSection(image: "onboarding2Icon",
                            title: LocalizedKeys.Onboarding.onboardingTitle2.stringValue(),
                            description: LocalizedKeys.Onboarding.onboardingSubtitle2.stringValue())

                OnBoardViewSection(image: "onboarding3Icon",
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

#Preview {
    OnboardingView()
}
