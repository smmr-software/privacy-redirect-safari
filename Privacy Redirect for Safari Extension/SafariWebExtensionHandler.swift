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
        let response = NSExtensionItem()
        
        let messageDict = message as? [String: String]
        if messageDict?["message"] == "Open Sesame" && app != nil {
            NSWorkspace.shared.openApplication(at: app!, configuration: NSWorkspace.OpenConfiguration())
            response.userInfo = [ SFExtensionMessageKey: [ "Response to": message ] ]
        } else if messageDict?["message"] == "redirectSettings" {
            response.userInfo = [
                SFExtensionMessageKey: [
                    "redirectNitter": defaults?.bool(forKey: "redirectNitter"),
                    "redirectReddit": defaults?.bool(forKey: "redirectReddit"),
                    "redirectInvidious": defaults?.bool(forKey: "redirectInvidious"),
                    "redirectSimplyTranslate": defaults?.bool(forKey: "redirectSimplyTranslate"),
                    "redirectOsm": defaults?.bool(forKey: "redirectOsm"),
                    "redirectSearchEngine": defaults?.bool(forKey: "redirectSearchEngine"),
                ]
            ]
        } else if messageDict?["message"] == "instanceSettings" {
            response.userInfo = [
                SFExtensionMessageKey: [
                    "nitterInstance": defaults?.string(forKey: "nitterInstance"),
                    "redditInstance": defaults?.string(forKey: "redditInstance"),
                    "invidiousInstance": defaults?.string(forKey: "invidiousInstance"),
                    "simplyTranslateInstance": defaults?.string(forKey: "simplyTranslateInstance"),
                    "osmInstance": defaults?.string(forKey: "osmInstance"),
                    "searchEngineInstance": defaults?.string(forKey: "searchEngineInstance"),
                ]
            ]
        }

        context.completeRequest(returningItems: [response], completionHandler: nil)
    }
    
}
