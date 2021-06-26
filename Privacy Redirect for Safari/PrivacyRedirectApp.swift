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
    let defaults = UserDefaults(suiteName: "com.smmr-software.Privacy-Redirect-for-Safari.group")
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
        let location = (defaults?.url(forKey: "location"))
        if location == nil || location != Bundle.main.bundleURL {
            defaults?.set(Bundle.main.bundleURL, forKey: "location")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .defaultAppStorage(defaults!)
                .environmentObject(appState)
                .onAppear(perform: refreshEnabledState)
                .onReceive(NotificationCenter.default.publisher(for: NSApplication.willBecomeActiveNotification)) { _ in
                    refreshEnabledState()
                }
                .frame(
                    minWidth: 250,
                    idealWidth: 300,
                    maxWidth: 350,
                    minHeight: 500,
                    idealHeight: 550,
                    maxHeight: 600
                )
        }
        .windowStyle(HiddenTitleBarWindowStyle())
        Settings {
            SettingsView()
                .defaultAppStorage(defaults!)
        }
    }
}
