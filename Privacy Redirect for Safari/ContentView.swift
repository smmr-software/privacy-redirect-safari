//
//  ContentView.swift
//  Privacy Redirect for Safari
//
//  Created by FIGBERT on 6/21/21.
//

import SwiftUI
import SafariServices.SFSafariApplication
import SafariServices.SFSafariExtensionManager

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    @AppStorage("redirectNitter") var redirectNitter = true
    @AppStorage("redirectReddit") var redirectReddit = true
    @AppStorage("redirectInvidious") var redirectInvidious = true
    @AppStorage("redirectSimplyTranslate") var redirectSimplyTranslate = true
    @AppStorage("redirectOsm") var redirectOsm = true
    @AppStorage("redirectSearchEngine") var redirectSearchEngine = true
    
    var body: some View {
        VStack {
            Spacer()
            Image(nsImage: NSImage(named: "AppIcon")!)
            VStack {
                Text("Privacy Redirect for Safari")
                    .font(.title)
                HStack(spacing: 2) {
                    Text("The extension is currently")
                    switch(self.appState.extensionEnabledState) {
                    case .enabled:
                        Text("enabled!")
                            .bold()
                    case _:
                        Text("disabled.")
                            .bold()
                    }
                }
            }
            Form {
                Toggle("Nitter Redirects", isOn: $redirectNitter)
                Toggle("Reddit Redirects", isOn: $redirectReddit)
                Toggle("Invidious Redirects", isOn: $redirectInvidious)
                Toggle("SimplyTranslate Redirects", isOn: $redirectSimplyTranslate)
                Toggle("Open Street Maps Redirects", isOn: $redirectOsm)
                Toggle("Search Engine Redirects", isOn: $redirectSearchEngine)
            }
            .padding(.vertical)
            Button("Open Privacy Redirect Preferences") {
                NSApp.sendAction(Selector(("showPreferencesWindow:")), to: nil, from: nil)
            }
            Button("Open Safari Extension Preferences") {
                SFSafariApplication.showPreferencesForExtension(withIdentifier: appState.identifier) { error in
                    guard error == nil else { return }
                    DispatchQueue.main.async {
                        NSApplication.shared.terminate(nil)
                    }
                }
            }
            Spacer()
        }
        .padding()
        .frame(maxWidth: 350)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AppState(initialExtensionEnabledState: .enabled))
        ContentView()
            .environmentObject(AppState(initialExtensionEnabledState: .disabled))
    }
}
