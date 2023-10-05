//
//  DifferencesView.swift
//  DevCodeReleases
//
//  Created by Raul on 8/6/23.
//

import SwiftUI

struct DifferencesView: View {
    var body: some View {
        VStack {
            ScrollView {
                Text("Release")
                    .font(.system(size: 22))
                    .padding()
                Text(LocalizedKeys.Menu.realaseExplanation)
                Divider()
                
                Text("Release Candidate (RC)")
                    .font(.system(size: 22))
                    .padding()
                
                Text(LocalizedKeys.Menu.rcExplanation)
                Divider()
                
                Text("Beta")
                    .font(.system(size: 22))
                    .padding()
                Text(LocalizedKeys.Menu.betaExplanation)
                Divider()
            }
        }
        .padding()
    }
}

#Preview {
    DifferencesView()
}
