//
//  Toast.swift
//
//  Created by Raúl Pascual on 17/4/23.
//

import Foundation
import SwiftUI

struct Toast: Equatable {
    var style: ToastStyle
    var message: String
    var duration: Double = .infinity
    var width: Double = .infinity
    var image: Image?
    var accesibilityLabel: String
    var buttonText: Text
    var action: (() -> Void)?
    
    static func == (lhs: Toast, rhs: Toast) -> Bool {
        return lhs.style == rhs.style &&
        lhs.message == rhs.message &&
        lhs.duration == rhs.duration &&
        lhs.width == rhs.width &&
        lhs.image == rhs.image &&
        lhs.accesibilityLabel == rhs.accesibilityLabel &&
        lhs.buttonText == rhs.buttonText
    }
}

enum ToastStyle {
    case error
    case warning
    case success
    case info
}

extension ToastStyle {
    var backgroundColor: Color {
        switch self {
        case .error:
            return Color.Toast.toastErrorColor
            
        case .warning:
            return Color.Toast.toastWarningColor
            
        case .info:
            return Color.Toast.toastInfoColor
            
        case .success:
            return Color.Toast.toastSuccessColor
        }
    }
    
    var foregorundColor: Color {
        switch self {
        case .error:
            return Color.Toast.toastForegroundErrorColor
            
        case .info, .warning, .success:
            return Color.Toast.toastForegroundColor
        }
    }
    
    var iconFileName: String {
        switch self {
        case .warning, .error:
            return "toastWarningIcon"
            
        case .success, .info:
            return "toastSuccessIcon"
        }
    }
}
