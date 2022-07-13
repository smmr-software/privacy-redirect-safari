//
//  AppState.swift
//  Privacy Redirect
//
//  Created by FIGBERT on 6/21/21.
//

import Foundation

enum ExtensionEnabledState {
    case undetermined
    case disabled
    case enabled
}

class AppState: ObservableObject {
    @Published var extensionEnabledState: ExtensionEnabledState
    public let identifier = "com.smmr-software.Privacy-Redirect-for-Safari.Extension"

    init(initialExtensionEnabledState: ExtensionEnabledState) {
        self.extensionEnabledState = initialExtensionEnabledState
    }
}
