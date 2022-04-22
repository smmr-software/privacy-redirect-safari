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

        let defaults = UserDefaults(suiteName: "\(Bundle.main.object(forInfoDictionaryKey: "TeamIdentifierPrefix") ?? "9WHCFZ6J4N.")Privacy-Redirect-for-Safari")
        let app = defaults?.url(forKey: "location")
        let response = NSExtensionItem()
        
        let messageDict = message as? [String: String]
        if messageDict?["message"] == "Open Sesame" && app != nil {
            NSWorkspace.shared.openApplication(at: app!, configuration: NSWorkspace.OpenConfiguration())
            response.userInfo = [ SFExtensionMessageKey: [ "Response to": message ] ]
        } else if messageDict?["message"] == "redirectSettings" {
            response.userInfo = [
                SFExtensionMessageKey: [
                    "nitter": !(defaults?.bool(forKey: "disableNitter") ?? false),
                    "reddit": !(defaults?.bool(forKey: "disableReddit") ?? false),
                    "invidious": !(defaults?.bool(forKey: "disableInvidious") ?? false),
                    "bibliogram": !(defaults?.bool(forKey: "disableBibliogram") ?? false),
                    "simplyTranslate": !(defaults?.bool(forKey: "disableSimplyTranslate") ?? false),
                    "osm": !(defaults?.bool(forKey: "disableOsm") ?? false),
                    "searchEngine": !(defaults?.bool(forKey: "disableSearchEngine") ?? false),
                    "scribe": !(defaults?.bool(forKey: "disableScribe") ?? false),
                    "proxiTok": !(defaults?.bool(forKey: "disableProxiTok") ?? false),
                ]
            ]
        } else if messageDict?["message"] == "instanceSettings" {
            let nitter = defaults?.string(forKey: "nitterInstance") ?? "nitter.net"
            let reddit = defaults?.string(forKey: "redditInstance") ?? "teddit.net"
            let invidious = defaults?.string(forKey: "invidiousInstance") ?? "invidious.snopyta.org"
            let bibliogram = defaults?.string(forKey: "bibliogramInstance") ?? "bibliogram.art"
            let simplyTranslate = defaults?.string(forKey: "simplyTranslateInstance") ?? "translate.metalune.xyz"
            let osm = defaults?.string(forKey: "osmInstance") ?? "openstreetmap.org"
            let searchEngine = defaults?.string(forKey: "searchEngineInstance") ?? "duckduckgo.com/"
            let scribe = defaults?.string(forKey: "scribeInstance") ?? "scribe.rip"
            let proxiTok = defaults?.string(forKey: "proxiTokInstance") ?? "proxitok.herokuapp.com"
            response.userInfo = [
                SFExtensionMessageKey: [
                    "nitter": nitter,
                    "reddit": reddit,
                    "invidious": invidious,
                    "bibliogram": bibliogram,
                    "simplyTranslate": simplyTranslate,
                    "osm": osm,
                    "searchEngine": searchEngine,
                    "scribe": scribe,
                    "proxiTok": proxiTok,
                ]
            ]
        }

        context.completeRequest(returningItems: [response], completionHandler: nil)
    }
    
}
