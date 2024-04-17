//
//  ViewExtension.swift
//  XcodeReleases
//
//  Created by Raul on 30/5/23.
//

import Foundation
import SwiftUI

extension View {
    func loaderBase(state: ViewModelState) -> some View {
        self.modifier(LoaderModifier(state: state, loader: AnyView(LoaderView())))
    }

    func iconStyle() -> some View {
        modifier(IconStyle())
    }
}

struct IconStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .scaledToFit()
            .frame(width: 30, height: 30)
    }
}

struct LoaderModifier: ViewModifier {
    var state: ViewModelState
    var loader: AnyView

    func body(content: Content) -> some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .center), content: {
            content
            if state == ViewModelState.loading {
                loader
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
        })
    }
}
