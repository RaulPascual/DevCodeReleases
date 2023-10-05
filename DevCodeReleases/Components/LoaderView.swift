//
//  LoaderView.swift
//  XcodeReleases
//
//  Created by Raul on 30/5/23.
//

import SwiftUI

struct LoaderView: View {
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: Alignment(horizontal: .center, vertical: .center)) {
                Rectangle()
                    .fill(Color.black.opacity(0.4))
                    .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                VStack(alignment: .center, spacing: 0.0) {
                    Spacer()
                    ProgressView()
                        .scaleEffect(2)
                        .font(.title)
                        .padding()
                    Spacer()
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    LoaderView()
}
