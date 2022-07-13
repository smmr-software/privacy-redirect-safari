//
//  PrivacyRedirectApp.swift
//  Privacy Redirect
//
//  Created by FIGBERT on 6/21/21.
//

import SwiftUI
import SafariServices.SFSafariExtensionManager
import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}

@main
struct PrivacyRedirectApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    let appState = AppState(initialExtensionEnabledState: .undetermined)
    let defaults = UserDefaults(suiteName: "\(Bundle.main.object(forInfoDictionaryKey: "TeamIdentifierPrefix") ?? "9WHCFZ6J4N.")Privacy-Redirect-for-Safari")
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

    @SceneBuilder var body: some Scene {
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
                    minHeight: 530,
                    idealHeight: 565,
                    maxHeight: 600
                )
        }
        .windowStyle(HiddenTitleBarWindowStyle())
        Settings {
            SettingsView()
                .navigationTitle("Instances")
                .frame(width: 300)
                .defaultAppStorage(defaults!)
        }
    }
}
