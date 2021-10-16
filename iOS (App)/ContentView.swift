//
//  ContentView.swift
//  Privacy Redirect for Safari
//
//  Created by FIGBERT on 6/21/21.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("disableNitter") var disableNitter = false
    @AppStorage("disableReddit") var disableReddit = false
    @AppStorage("disableInvidious") var disableInvidious = false
    @AppStorage("disableSimplyTranslate") var disableSimplyTranslate = false
    @AppStorage("disableOsm") var disableOsm = false
    @AppStorage("disableSearchEngine") var disableSearchEngine = false
    
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
        
        return VStack {
            Spacer()
            Image(uiImage: UIImage(named: "LargeIcon")!)
                .resizable()
                .frame(
                    width: 150,
                    height: 150,
                    alignment: .center
                )
            Text("Privacy Redirect for Safari")
                .font(.title)
            Text("Enable the extension in Safari Settings")
                .font(.subheadline)
            Spacer()
            VStack {
                Toggle("Twitter Redirects", isOn: redirectNitter)
                Toggle("Reddit Redirects", isOn: redirectReddit)
                Toggle("YouTube Redirects", isOn: redirectInvidious)
                Toggle("Google Translate Redirects", isOn: redirectSimplyTranslate)
                Toggle("Google Maps Redirects", isOn: redirectOsm)
                Toggle("Google Search Redirects", isOn: redirectSearchEngine)
            }
                .padding()
            Spacer()
            Button("Configure Privacy Redirect Instances") {
                // Stuff
            }
            Spacer()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
