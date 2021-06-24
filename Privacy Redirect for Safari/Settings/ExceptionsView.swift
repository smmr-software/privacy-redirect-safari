//
//  ExceptionsView.swift
//  Privacy Redirect for Safari
//
//  Created by FIGBERT on 6/24/21.
//

import SwiftUI

struct ExceptionsView: View {
    @State var exceptionField = ""
    @State var exceptionType = 0
    
    var body: some View {
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
    }
}

struct ExceptionsView_Previews: PreviewProvider {
    static var previews: some View {
        ExceptionsView()
    }
}
