//
//  ToastModifier.swift
//
//  Created by Raúl Pascual on 17/4/23.
//

import Foundation
import SwiftUI

struct ToastModifier: ViewModifier {
    @Binding var toast: Toast?
    @State private var workItem: DispatchWorkItem?
    @ScaledMetric var scale: CGFloat = 1
    @Environment(\.sizeCategory) var sizeCategory
    
    func body(content: Content) -> some View {
        content
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(
                GeometryReader(content: { proxy in
                    if sizeCategory < .large {
                        ZStack {
                            mainToastView()
                                .offset(y: proxy.size.height - (65 * scale))
                        }.animation(.spring(), value: toast)
                    } else if sizeCategory >= .large {
                        ZStack {
                            mainToastView()
                                .offset(y: proxy.size.height - (140 * scale))
                        }.animation(.spring(), value: toast)
                    }
                })
            )
            .onChange(of: toast) { _, _ in
                showToast()
            }
    }
    
    @ViewBuilder func mainToastView() -> some View {
        if let toast = toast {
            VStack {
                ToastView(style: toast.style,
                          message: toast.message,
                          width: toast.width,
                          image: toast.image,
                          accesibilityLabel: toast.accesibilityLabel,
                          buttonText: toast.buttonText,
                          buttonAction: toast.action ?? dismissToast)
                Spacer()
            }
            .frame(maxWidth: .infinity)
        }
    }
    
    private func showToast() {
        guard let toast = toast else {
            return
        }
        
        UIImpactFeedbackGenerator(style: .light)
            .impactOccurred()
        
        if toast.duration > 0 {
            workItem?.cancel()
            
            let task = DispatchWorkItem {
                dismissToast()
            }
            
            workItem = task
            DispatchQueue.main.asyncAfter(deadline: .now() + toast.duration, execute: task)
        }
    }
    
    private func dismissToast() {
        withAnimation {
            toast = nil
        }
        
        workItem?.cancel()
        workItem = nil
    }
}
