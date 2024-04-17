//
//  ViewExtension.swift
//  XcodeReleases
//
//  Created by Raul on 30/5/23.
//

import Foundation
import SwiftUI

extension View {
    func loaderApp(state: ViewModelState) -> some View {
        self.modifier(LoaderModifier(state: state, loader: AnyView(LoaderView())))
    }

    func loaderBase(state: ViewModelState) -> some View {
        self.modifier(LoaderModifier(state: state, loader: AnyView(LoaderView())))
    }

    // Create a ViewBuilder function that can be applied to any type of content conforming to view
    @ViewBuilder func conditionalModifier<Content: View>(_ condition: Bool,
                                                         transform: (Self) -> Content) -> some View {
        if condition {
            // If condition matches, apply the transform
            transform(self)
        } else {
            // If not, just return the original view
            self
        }
    }

    @ViewBuilder
    func iOSPopover<Content: View>(isPresented: Binding<Bool>,
                                   arrowDirection: UIPopoverArrowDirection,
                                   @ViewBuilder content: @escaping () -> Content) -> some View {
        self
            .background {
                PopOverController(isPresented: isPresented, arrowDirection:
                                    arrowDirection, content: content())
            }
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

struct PopOverController<Content: View>: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    var arrowDirection: UIPopoverArrowDirection
    var content: Content

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UIViewController()
        controller.view.backgroundColor = .clear
        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if isPresented {
            // - Presenting Popover
            let controller = CustomHostingView(rootView: content)
            controller.view.backgroundColor = .clear
            controller.modalPresentationStyle = .popover
            controller.popoverPresentationController?.permittedArrowDirections = arrowDirection
            // - Connecting delegate
            controller.presentationController?.delegate = context.coordinator
            // - We Need to Attach the Source View So that it will show Arrow At Correct Position
            controller.popoverPresentationController?.sourceView = uiViewController.view
            // - Simply Presenting PopOver Controller
            uiViewController.present(controller, animated: true)
        }
    }

    // - Forcing it to show Popover using PresentationDelegate
    class Coordinator: NSObject, UIPopoverPresentationControllerDelegate {
        var parent: PopOverController
        init (parent: PopOverController) {
            self.parent = parent
        }

        func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
            return .none
        }

        func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
            parent.isPresented = false
        }
    }
}

// - Custom Hosting Controller for Wrapping to it's SwiftUI View Size
class CustomHostingView<Content: View>: UIHostingController<Content> {
    override func viewDidLoad() {
        super.viewDidLoad()
        preferredContentSize = view.intrinsicContentSize
    }
}
