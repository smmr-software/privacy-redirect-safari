//
//  Instances.swift
//  Privacy Redirect for Safari
//
//  Created by figbert on 3/4/22.
//

import Foundation


struct Instances {
    public let nitter = [
        "nitter.net",
        "nitter.nixnet.services",
    ]
    public let reddit = [
        "libredd.it",
        "teddit.net",
        "old.reddit.com",
    ]
    public let invidious = [
        "invidious.snopyta.org",
        "invidious.kavin.rocks",
        "piped.kavin.rocks",
    ]
    public let bibliogram = [
        "bibliogram.art",
        "bibliogram.snopyta.org",
        "bibliogram.pussthecat.org",
        "bibliogram.1d4.us",
        "insta.trom.tf",
        "bib.riverside.rocks",
        "bibliogram.esmailelbob.xyz",
        "bib.actionsack.com",
        "biblio.alefvanoon.xyz",
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
        SearchEngineInstance("startpage.com", path: "/search/"),
        SearchEngineInstance("www.ecosia.org", path: "/search"),
        SearchEngineInstance("www.qwant.com"),
        SearchEngineInstance("www.mojeek.com", path: "/search"),
        SearchEngineInstance("searx.info"),
        SearchEngineInstance("searx.tuxcloud.net"),
        SearchEngineInstance("whoogle.sdf.org", path: "/search"),
    ]
    public let scribe = [
        "scribe.rip",
        "scribe.nixnet.services",
        "scribe.citizen4.eu",
    ]
    public let proxiTok = [
        "proxitok.herokuapp.com",
        "proxitok.pussthecat.org",
    ]
    public let rimgo = [
        "i.bcow.xyz",
        "rimgo.pussthecat.org",
        "img.riverside.rocks",
        "rimgo.bus-hit.me",
    ]
}
