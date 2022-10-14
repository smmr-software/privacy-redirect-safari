//
//  ContentView.swift
//  Privacy Redirect
//
//  Created by FIGBERT on 6/21/21.
//

import Foundation
import SwiftUI
import SafariServices.SFSafariApplication
import SafariServices.SFSafariExtensionManager

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    @AppStorage("disableNitter") var disableNitter = false
    @AppStorage("disableReddit") var disableReddit = false
    @AppStorage("disableInvidious") var disableInvidious = false
    @AppStorage("disableBibliogram") var disableBibliogram = false
    @AppStorage("disableSimplyTranslate") var disableSimplyTranslate = false
    @AppStorage("disableOsm") var disableOsm = false
    @AppStorage("disableSearchEngine") var disableSearchEngine = false
    @AppStorage("disableScribe") var disableScribe = false
    @AppStorage("disableProxiTok") var disableProxiTok = false
    @AppStorage("disableRimgo") var disableRimgo = false
    @AppStorage("disableQuetre") var disableQuetre = false
    @AppStorage("disableLibremDB") var disableLibremDB = false

    var body: some View {
        let redirectNitter = Binding<Bool>(
            get: { !self.disableNitter },
            set: { value in self.disableNitter = !value }
        )
        let redirectReddit = Binding<Bool>(
            get: { !self.disableReddit },
            set: { value in self.disableReddit = !value }
        )
        let redirectInvidious = Binding<Bool>(
            get: { !self.disableInvidious },
            set: { value in self.disableInvidious = !value }
        )
        let redirectBibliogram = Binding<Bool>(
            get: { !self.disableBibliogram },
            set: { value in self.disableBibliogram = !value }
        )
        let redirectSimplyTranslate = Binding<Bool>(
            get: { !self.disableSimplyTranslate },
            set: { value in self.disableSimplyTranslate = !value }
        )
        let redirectOsm = Binding<Bool>(
            get: { !self.disableOsm },
            set: { value in self.disableOsm = !value }
        )
        let redirectSearchEngine = Binding<Bool>(
            get: { !self.disableSearchEngine },
            set: { value in self.disableSearchEngine = !value }
        )
        let redirectScribe = Binding<Bool>(
            get: { !self.disableScribe },
            set: { value in self.disableScribe = !value }
        )
        let redirectProxiTok = Binding<Bool>(
            get: { !self.disableProxiTok },
            set: { value in self.disableProxiTok = !value }
        )
        let redirectRimgo = Binding<Bool>(
            get: { !self.disableRimgo },
            set: { value in self.disableRimgo = !value }
        )
        let redirectQuetre = Binding<Bool>(
            get: { !self.disableQuetre },
            set: { value in self.disableQuetre = !value }
        )
        let redirectLibremDB = Binding<Bool>(
            get: { !self.disableLibremDB },
            set: { value in self.disableLibremDB = !value }
        )

        return VStack {
            Spacer()
            Image(nsImage: NSImage(named: "AppIcon")!)
            VStack {
                Text("Privacy Redirect")
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
                Group {
                    Toggle("Twitter Redirects", isOn: redirectNitter)
                    Toggle("Reddit Redirects", isOn: redirectReddit)
                    Toggle("YouTube Redirects", isOn: redirectInvidious)
                    Toggle("Instagram Redirects", isOn: redirectBibliogram)
                }
                Group {
                    Toggle("Google Translate Redirects", isOn: redirectSimplyTranslate)
                    Toggle("Google Maps Redirects", isOn: redirectOsm)
                    Toggle("Search Redirects", isOn: redirectSearchEngine)
                }
                Group {
                    Toggle("Medium Redirects", isOn: redirectScribe)
                    Toggle("TikTok Redirects", isOn: redirectProxiTok)
                    Toggle("Imgur Redirects", isOn: redirectRimgo)
                    Toggle("Quora Redirects", isOn: redirectQuetre)
                    Toggle("IMDB Redirects", isOn: redirectLibremDB)
                }
            }
            .padding(.vertical)
            Button("Instructions and Instance Settings") {
                let info = ProcessInfo()
                var command = "showPreferencesWindow"

                if info.isOperatingSystemAtLeast(OperatingSystemVersion(majorVersion: 13,minorVersion: 0,patchVersion: 0)) {
                    command = "showSettingsWindow"
                }

                NSApp.sendAction(Selector(("\(command):")), to: nil, from: nil)
            }
            Button("Open Safari Extension Preferences") {
                SFSafariApplication.showPreferencesForExtension(withIdentifier: appState.identifier) { error in
                    guard error == nil else { return }
                    DispatchQueue.main.async {
                        NSApplication.shared.terminate(nil)
                    }
                }
            }
            .padding(.bottom)
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
