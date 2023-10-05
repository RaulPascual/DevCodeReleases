//
//  ToastView.swift
//
//  Created by Raúl Pascual on 17/4/23.
//

import SwiftUI

struct ToastView: View {
    var style: ToastStyle
    var message: String
    var width = CGFloat.infinity
    var image: Image?
    var accesibilityLabel: String
    var buttonText: Text
    var buttonAction: (() -> Void)
    @ScaledMetric var scale: CGFloat = 1

    var body: some View {
        VStack {
            HStack {
                if let image {
                    image
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding(.trailing, 12)
                        .padding(.leading, 16)
                        .foregroundColor(style == .error ? Color.Toast.toastForegroundErrorColor : Color.Toast.toastForegroundColor)
                } else {
                    Image(style.iconFileName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24 * scale, height: 24 * scale)
                }
                
                Text(message)
                    .bold()
                    .customFont(size: 14, color: style.foregorundColor)
                    .padding(.trailing, 30)
                    .accessibility(label: Text(accesibilityLabel))
                
                Spacer()
                
                Button {
                    buttonAction()
                } label: {
                    buttonText
                        .bold()
                        .customFont(size: 14, color: style.foregorundColor)
                }
                .padding(.trailing, 16)
            }
            .padding(.all, 16)
            .background(
                Rectangle()
                    .cornerRadius(8)
                    .foregroundColor(style.backgroundColor)
            )
        }
        .padding()
        .frame(maxWidth: .infinity)
    }
}
