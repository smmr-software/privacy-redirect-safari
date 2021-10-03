//
//  SettingsView.swift
//  Privacy Redirect for Safari
//
//  Created by figbert on 7/24/21.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        TabView {
            InstancesView()
                .padding()
                .tabItem {
                    Text("Instances")
                    Image(systemName: "server.rack")
                }
            VStack {
                Text("Privacy Redirect for Safari - v\(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String)")
                Link(destination: URL(string: "https://smmr.software/")!) { Text("by SMMR Software") }
            }
                .padding()
                .tabItem {
                    Text("About")
                    Image(systemName: "book")
                }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
