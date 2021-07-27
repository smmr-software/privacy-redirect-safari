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

        let defaults = UserDefaults(suiteName: "9WHCFZ6J4N.Privacy-Redirect-for-Safari")
        let app = defaults?.url(forKey: "location")
        let response = NSExtensionItem()
        
        let messageDict = message as? [String: String]
        if messageDict?["message"] == "Open Sesame" && app != nil {
            NSWorkspace.shared.openApplication(at: app!, configuration: NSWorkspace.OpenConfiguration())
            response.userInfo = [ SFExtensionMessageKey: [ "Response to": message ] ]
        } else if messageDict?["message"] == "redirectSettings" {
            response.userInfo = [
                SFExtensionMessageKey: [
                    "nitter": defaults?.bool(forKey: "redirectNitter"),
                    "reddit": defaults?.bool(forKey: "redirectReddit"),
                    "invidious": defaults?.bool(forKey: "redirectInvidious"),
                    "simplyTranslate": defaults?.bool(forKey: "redirectSimplyTranslate"),
                    "osm": defaults?.bool(forKey: "redirectOsm"),
                    "searchEngine": defaults?.bool(forKey: "redirectSearchEngine"),
                ]
            ]
        } else if messageDict?["message"] == "instanceSettings" {
            response.userInfo = [
                SFExtensionMessageKey: [
                    "nitter": defaults?.string(forKey: "nitterInstance"),
                    "reddit": defaults?.string(forKey: "redditInstance"),
                    "invidious": defaults?.string(forKey: "invidiousInstance"),
                    "simplyTranslate": defaults?.string(forKey: "simplyTranslateInstance"),
                    "osm": defaults?.string(forKey: "osmInstance"),
                    "searchEngine": defaults?.string(forKey: "searchEngineInstance"),
                ]
            ]
        }

        context.completeRequest(returningItems: [response], completionHandler: nil)
    }
    
}
