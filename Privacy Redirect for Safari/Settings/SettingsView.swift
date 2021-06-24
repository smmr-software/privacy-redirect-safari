//
//  SettingsView.swift
//  Privacy Redirect for Safari
//
//  Created by FIGBERT on 6/23/21.
//

import SwiftUI


struct SettingsView: View {
    @State var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            InstancesView()
                .padding()
                .tabItem {
                    Text("Instances")
                    Image(systemName: "server.rack")
                }
                .tag(0)
            VStack {
                Text("ipsum")
            }
                .tabItem {
                    Text("Advanced")
                    Image(systemName: "gearshape.2")
                }
                .tag(1)
            ExceptionsView()
                .padding()
                .tabItem {
                    Text("Exceptions")
                    Image(systemName: "chevron.left.slash.chevron.right")
                }
                .tag(2)
        }
            .frame(width: 300)
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(selection: 0)
            .defaultAppStorage(UserDefaults(suiteName: "com.smmr-software.Privacy-Redirect-for-Safari.group")!)
        SettingsView(selection: 1)
            .defaultAppStorage(UserDefaults(suiteName: "com.smmr-software.Privacy-Redirect-for-Safari.group")!)
        SettingsView(selection: 2)
            .defaultAppStorage(UserDefaults(suiteName: "com.smmr-software.Privacy-Redirect-for-Safari.group")!)
    }
}
