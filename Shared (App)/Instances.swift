//
//  Instances.swift
//  Privacy Redirect
//
//  Created by figbert on 3/4/22.
//

import Foundation


struct Instances {
    public let nitter = [
        "nitter.net",
        "nitter.pussthecat.org",
        "nitter.lacontrevoie.fr",
    ]
    public let reddit = [
        "libredd.it",
        "teddit.net",
        "old.reddit.com",
    ]
    public let invidious = [
        "invidious.kavin.rocks",
        "piped.kavin.rocks",
    ]
    public let simplyTranslate = [
        "simplytranslate.org",
        "translate.bus-hit.me",
        "simplytranslate.pussthecat.org",
    ]
    public let maps = [
         "openstreetmap.org",
    ]
    public let searchEngines = [
        SearchEngineInstance("duckduckgo.com"),
        SearchEngineInstance("startpage.com", path: "/sp/search"),
        SearchEngineInstance("www.ecosia.org", path: "/search"),
        SearchEngineInstance("www.qwant.com"),
        SearchEngineInstance("searx.work"),
        SearchEngineInstance("search.unlocked.link"),
    ]
    public let scribe = [
        "scribe.rip",
        "scribe.nixnet.services",
        "scribe.citizen4.eu",
    ]
    public let proxiTok = [
        "proxitok.pabloferreiro.es",
        "proxitok.pussthecat.org",
    ]
    public let rimgo = [
        "i.bcow.xyz",
        "rimgo.totaldarkness.net",
        "rimgo.pussthecat.org",
        "imgur.artemislena.eu",
    ]
    public let quetre = [
        "quetre.iket.me",
        "qr.vern.cc",
        "quetre.pussthecat.org",
    ]
    public let libremdb = [
        "libremdb.iket.me",
        "ld.vern.cc",
        "libremdb.pussthecat.org",
    ]
}

struct SearchEngineInstance {
    public let link: String
    public let path: String
    public let url: String
    public let id = UUID()

    init(_ link: String, path: String = "/") {
        self.link = link
        self.path = path
        self.url = link + path
    }
}
