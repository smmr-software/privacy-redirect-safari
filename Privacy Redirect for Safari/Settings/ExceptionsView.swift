//
//  ExceptionsView.swift
//  Privacy Redirect for Safari
//
//  Created by FIGBERT on 6/24/21.
//

import SwiftUI

struct ExceptionsView: View {
    @AppStorage("exceptions") var exceptions = [UUID: [String: String]]()
    
    @State var exceptionField = ""
    @State var exceptionType = 0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Enter a URL or Regular Expression to be excluded from redirects.")
            Text("All requests for or initiating from a URL that matches the exception will be excluded from redirects.")
            Text("Note: Supports JavaScript regular expressions, excluding the enclosing forward slashes.")
            VStack(alignment: .leading) {
                Text("Add Exception")
                    .bold()
                HStack {
                    TextField("URL or RegExp", text: $exceptionField, onCommit: { addException() })
                    Picker(selection: $exceptionType,
                           label: Text("Exception Type"), content: {
                        Text("URL").tag(0)
                        Text("RegExp").tag(1)
                    })
                        .labelsHidden()
                        .pickerStyle(SegmentedPickerStyle())
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.accentColor)
                        .onTapGesture(perform: {
                            addException()
                        })
                }
                ScrollView {
                    VStack(alignment: .leading, spacing: 3) {
                        ForEach(exceptions.sorted(by: {
                            let first = $0.value
                            let second = $1.value
                            return first["string"]! < second["string"]!
                        }), id: \.key) { (id, dict) in
                            HStack {
                                Text("\(dict["string"]!)")
                                Spacer()
                                Text("(\(dict["type"]!))")
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.accentColor)
                                    .onTapGesture(perform: {
                                        withAnimation(.easeIn(duration: 0.1)) {
                                            self.exceptions.removeValue(forKey: id)
                                        }
                                    })
                            }
                        }
                    }
                }
            }
                .padding(.top, 10)
            Spacer()
        }
    }
    
    func addException() {
        withAnimation(.easeIn(duration: 0.1)) {
            self.exceptions[UUID()] = [
                "string": exceptionField,
                "type": exceptionType == 0 ? "URL" : "RegExp",
            ]
        }
        exceptionField = ""
        exceptionType = 0
    }
}

struct ExceptionsView_Previews: PreviewProvider {
    static var previews: some View {
        ExceptionsView()
    }
}
