//
//  BaseExtension.swift
//  XcodeReleases
//
//  Created by Raul on 30/5/23.
//

import Foundation
import SwiftUI

enum ViewModelState: String {
    case okey
    case loading
    case error
    case unknownError
    case notReachable
    case empty
}

@Observable public class BaseViewModel {
     var state: ViewModelState = .okey
     var showWarningError = false
}

public class BaseBusiness: HTTPClient {
}
