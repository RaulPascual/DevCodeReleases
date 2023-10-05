//
//  TextExtension.swift
//  XcodeReleases
//
//  Created by Raul on 30/5/23.
//

import Foundation
import SwiftUI

extension Text {
    func customFont(size: CGFloat, color: Color? = nil) -> Text {
        var text = self
            text = text.font(.system(size: size))
        if let color = color {
            text = text.foregroundColor(color)
        }
        return text
    }
}
