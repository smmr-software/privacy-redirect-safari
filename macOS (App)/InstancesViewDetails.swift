//
//  InstancesView.swift
//  Privacy Redirect
//
//  Created by FIGBERT on 6/24/21.
//

import SwiftUI

struct InstanceSection: View {
    public let name: String
    public let customInstance: Binding<Bool>
    public let instance: Binding<String>
    public let instances: Array<String>

    var body: some View {
        Section(header: Text(name).bold(), content: {
            HStack {
            if !customInstance.wrappedValue {
                Picker(selection: instance,
                       label: Text("Instance"), content: {
                        ForEach(instances, id: \.self) { instance in
                            Text("\(instance)").tag(instance)
                        }
                })
            } else {
                TextField("\(name) Instance", text: instance)
            }
                Toggle("Custom", isOn: customInstance)
            }
        })
    }
}

struct InstanceViewContainer<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        Form {
            content
        }
        .labelsHidden()
    }
}
