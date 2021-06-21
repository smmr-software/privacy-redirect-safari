//
//  PrivacyRedirectApp.swift
//  Privacy Redirect for Safari
//
//  Created by FIGBERT on 6/21/21.
//

import SwiftUI
import SafariServices.SFSafariExtensionManager

@main
struct PrivacyRedirectApp: App {
    let appState = AppState(initialExtensionEnabledState: .undetermined)
    func refreshEnabledState() {
        SFSafariExtensionManager.getStateOfSafariExtension(withIdentifier: appState.identifier, completionHandler: { (state, error) in
            guard error == nil else {
                DispatchQueue.main.async {
                    appState.extensionEnabledState = .undetermined
                }
                return
            }
            if let state = state {
                DispatchQueue.main.async {
                    appState.extensionEnabledState = state.isEnabled ? .enabled : .disabled
                }
            }
        })
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
                .onAppear(perform: refreshEnabledState)
                .onReceive(NotificationCenter.default.publisher(for: NSApplication.willBecomeActiveNotification)) { _ in
                    refreshEnabledState()
                }
                .frame(
                    minWidth: 320,
                    idealWidth: 350,
                    maxWidth: 500,
                    minHeight: 440,
                    idealHeight: 460,
                    maxHeight: 600
                )
        }
    }
}
