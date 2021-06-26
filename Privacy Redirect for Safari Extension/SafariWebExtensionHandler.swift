//
//  SafariWebExtensionHandler.swift
//  Privacy Redirect for Safari Extension
//
//  Created by FIGBERT on 6/11/21.
//

import SafariServices
import os.log

let SFExtensionMessageKey = "message"

class SafariWebExtensionHandler: NSObject, NSExtensionRequestHandling {

	func beginRequest(with context: NSExtensionContext) {
        let item = context.inputItems[0] as! NSExtensionItem
        let message = item.userInfo?[SFExtensionMessageKey]
        os_log(.default, "Received message from browser.runtime.sendNativeMessage: %@", message as! CVarArg)

        let defaults = UserDefaults(suiteName: "com.smmr-software.Privacy-Redirect-for-Safari.group")
        let app = defaults?.url(forKey: "location")
        
        let messageDict = message as? [String: String]
        if messageDict?["message"] == "Open Sesame" && app != nil {
            NSWorkspace.shared.openApplication(at: app!, configuration: NSWorkspace.OpenConfiguration())
        }
        
        let response = NSExtensionItem()
        response.userInfo = [ SFExtensionMessageKey: [ "Response to": message ] ]

        context.completeRequest(returningItems: [response], completionHandler: nil)
    }
    
}
