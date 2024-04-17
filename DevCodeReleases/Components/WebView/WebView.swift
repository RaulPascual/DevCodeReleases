//
//  WebView.swift
//  DevCodeReleases
//
//  Created by Raul on 5/10/23.
//

import WebKit
import UIKit
import SwiftUI

struct WebView: UIViewRepresentable {
    @State var url: String

    func makeUIView(context: Context) -> some UIView {
        let webView = WKWebView(frame: .zero)
        if let url = URL(string: url) {
            webView.load(URLRequest(url: url))
        }
        
        return webView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {}
}
