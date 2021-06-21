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
    
    var body: some View {
        VStack(alignment: .center, spacing: 40) {
            Spacer()
            Image(nsImage: NSImage(named: "AppIcon")!)
            Group {
                switch(self.appState.extensionEnabledState) {
                case .enabled: Text("Privacy Redirect for Safari is enabled!")
                case _: Text("Privacy Redirect for Safari is off. You can turn it on in Safari Extensions preferences.").multilineTextAlignment(.center)
                }
            }
            Button("Quit and Open Safari Extensions Preferences…") {
                SFSafariApplication.showPreferencesForExtension(withIdentifier: appState.identifier) { error in
                    guard error == nil else {
                        return
                    }
                    DispatchQueue.main.async {
                        NSApplication.shared.terminate(nil)
                    }
                }
            }
            Spacer()
        }
        .padding()
        .frame(maxWidth: 400)
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
