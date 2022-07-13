//
//  SafariWebExtensionHandler.swift
//  Privacy Redirect (iOS) Extension
//
//  Created by figbert on 10/3/21.
//

import SafariServices
import os.log

let SFExtensionMessageKey = "message"

class SafariWebExtensionHandler: NSObject, NSExtensionRequestHandling {

    func beginRequest(with context: NSExtensionContext) {
        let item = context.inputItems[0] as! NSExtensionItem
        let message = item.userInfo?[SFExtensionMessageKey]
        os_log(.default, "Received message from browser.runtime.sendNativeMessage: %@", message as! CVarArg)

        let defaults = UserDefaults(suiteName: "group.Privacy-Redirect-for-Safari")
        let response = NSExtensionItem()

        let messageDict = message as? [String: String]
        if messageDict?["message"] == "redirectSettings" {
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
                    "rimgo": !(defaults?.bool(forKey: "disableRimgo") ?? false),
                ]
            ]
        } else if messageDict?["message"] == "instanceSettings" {
            let nitter = defaults?.string(forKey: "nitterInstance") ?? "nitter.net"
            let reddit = defaults?.string(forKey: "redditInstance") ?? "teddit.net"
            let invidious = defaults?.string(forKey: "invidiousInstance") ?? "invidious.kavin.rocks"
            let bibliogram = defaults?.string(forKey: "bibliogramInstance") ?? "bibliogram.art"
            let simplyTranslate = defaults?.string(forKey: "simplyTranslateInstance") ?? "simplytranslate.org"
            let osm = defaults?.string(forKey: "osmInstance") ?? "openstreetmap.org"
            let searchEngine = defaults?.string(forKey: "searchEngineInstance") ?? "duckduckgo.com/"
            let scribe = defaults?.string(forKey: "scribeInstance") ?? "scribe.rip"
            let proxiTok = defaults?.string(forKey: "proxiTokInstance") ?? "proxitok.herokuapp.com"
            let rimgo = defaults?.string(forKey: "rimgoInstance") ?? "i.bcow.xyz"
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
                    "rimgo": rimgo,
                ]
            ]
        }

        context.completeRequest(returningItems: [response], completionHandler: nil)
    }

}
