//
//  InstructionsView.swift
//  Privacy Redirect
//
//  Created by figbert on 22/7/22.
//

import SwiftUI

struct InstructionsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("1. Activate redirects and configure instances")
            #if os(iOS)
            Text("2. Open Settings → Safari → Extensions")
            #else
            Text("2. Open Safari Extension Preferences")
            #endif
            Text("3. Enable Privacy Redirect")
            Text("4. In the Permissions section, allow access to all sites")
            Text("5. Enjoy privacy!")
        }
    }
}

struct InstructionsView_Previews: PreviewProvider {
    static var previews: some View {
        InstructionsView()
    }
}
