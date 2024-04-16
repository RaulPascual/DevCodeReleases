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
    @State var url: String // 1

    func makeUIView(context: Context) -> some UIView {
        let webView = WKWebView(frame: .zero) // 2
        webView.load(URLRequest(url: URL(string: url)!)) // 3
        return webView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {} // 4
}
