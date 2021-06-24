//
//  SettingsView.swift
//  Privacy Redirect for Safari
//
//  Created by FIGBERT on 6/23/21.
//

import SwiftUI


struct SettingsView: View {
    @State var selection = 0
    @State var exceptionField = ""
    @State var exceptionType = 0
    
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
            VStack(alignment: .leading, spacing: 10) {
                Text("Enter a URL or Regular Expression to be excluded from redirects.")
                Text("All requests for or initiating from a URL that matches the exception will be excluded from redirects.")
                Text("Note - Supports JavaScript regular expressions, excluding the enclosing forward slashes.")
                VStack(alignment: .leading) {
                    Text("Add Exception")
                        .bold()
                    HStack {
                        TextField("URL or RegExp", text: $exceptionField)
                        Picker(selection: $exceptionType,
                               label: Text("Exception Type"), content: {
                            Text("URL").tag(0)
                            Text("RegExp").tag(1)
                        })
                            .labelsHidden()
                            .pickerStyle(SegmentedPickerStyle())
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.accentColor)
                    }
                }
                    .padding(.top, 20)
                Spacer()
            }
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
