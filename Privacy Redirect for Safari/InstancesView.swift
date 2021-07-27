//
//  InstancesView.swift
//  Privacy Redirect for Safari
//
//  Created by FIGBERT on 6/24/21.
//

import SwiftUI

struct InstancesView: View {
    @AppStorage("useCustomNitterInstance") var useCustomNitterInstance = false
    @AppStorage("useCustomRedditInstance") var useCustomRedditInstance = false
    @AppStorage("useCustomInvidiousInstance") var useCustomInvidiousInstance = false
    @AppStorage("useCustomSimplyTranslateInstance") var useCustomSimplyTranslateInstance = false
    @AppStorage("useCustomOsmInstance") var useCustomOsmInstance = false
    @AppStorage("useCustomSearchEngineInstance") var useCustomSearchEngineInstance = false
    
    @AppStorage("nitterInstance") var nitterInstance = "nitter.net"
    @AppStorage("redditInstance") var redditInstance = "teddit.net"
    @AppStorage("invidiousInstance") var invidiousInstance = "invidious.snopyta.org"
    @AppStorage("simplyTranslateInstance") var simplyTranslateInstance = "translate.metalune.xyz"
    @AppStorage("osmInstance") var osmInstance = "openstreetmap.org"
    @AppStorage("searchEngineInstance") var searchEngineInstance = "duckduckgo.com/"
    
    let instances = Instances()
    
    var body: some View {
        Form {
            Section(header: Text("Nitter").bold(), content: {
                HStack {
                if !useCustomNitterInstance {
                    Picker(selection: $nitterInstance,
                           label: Text("Instance"), content: {
                            ForEach(instances.nitter, id: \.self) { instance in
                                Text("\(instance)").tag(instance)
                            }
                    })
                        .labelsHidden()
                } else {
                    TextField("Nitter Instance", text: $nitterInstance)
                }
                    Toggle("Custom", isOn: $useCustomNitterInstance)
                }
            })
            Section(header: Text("Teddit or Libreddit").bold(), content: {
                HStack {
                    if !useCustomRedditInstance {
                        Picker(selection: $redditInstance,
                               label: Text("Instance"), content: {
                                ForEach(instances.reddit, id: \.self) { instance in
                                    Text("\(instance)").tag(instance)
                                }
                        })
                            .labelsHidden()
                    } else {
                        TextField("Reddit Instance", text: $redditInstance)
                    }
                    Toggle("Custom", isOn: $useCustomRedditInstance)
                }
            })
            Section(header: Text("Invidious").bold(), content: {
                HStack {
                    if !useCustomInvidiousInstance {
                        Picker(selection: $invidiousInstance,
                               label: Text("Instance"), content: {
                                ForEach(instances.invidious, id: \.self) { instance in
                                    Text("\(instance)").tag(instance)
                                }
                        })
                            .labelsHidden()
                    } else {
                        TextField("Invidious Instance", text: $invidiousInstance)
                    }
                    Toggle("Custom", isOn: $useCustomInvidiousInstance)
                }
            })
            Section(header: Text("SimplyTranslate").bold(), content: {
                HStack {
                    if !useCustomSimplyTranslateInstance {
                        Picker(selection: $simplyTranslateInstance,
                               label: Text("Instance"), content: {
                                ForEach(instances.simplyTranslate, id: \.self) { instance in
                                    Text("\(instance)").tag(instance)
                                }
                        })
                            .labelsHidden()
                    } else {
                        TextField("SimplyTranslate Instance", text: $simplyTranslateInstance)
                    }
                    Toggle("Custom", isOn: $useCustomSimplyTranslateInstance)
                }
            })
            Section(header: Text("OpenStreetMap").bold(), content: {
                HStack {
                    if !useCustomOsmInstance {
                        Picker(selection: $osmInstance,
                               label: Text("Instance"), content: {
                                ForEach(instances.maps, id: \.self) { instance in
                                    Text("\(instance)").tag(instance)
                                }
                        })
                            .labelsHidden()
                    } else {
                        TextField("OpenStreetMap Instance", text: $osmInstance)
                    }
                    Toggle("Custom", isOn: $useCustomOsmInstance)
                }
            })
            Section(header: Text("Search Engine").bold(), content: {
                HStack {
                    if !useCustomSearchEngineInstance {
                        Picker(selection: $searchEngineInstance,
                               label: Text("Instance"), content: {
                                ForEach(instances.searchEngines, id: \.id) { instance in
                                    Text("\(instance.link)").tag(instance.url)
                                }
                        })
                            .labelsHidden()
                    } else {
                        TextField("Search Engine Instance (including path)", text: $searchEngineInstance)
                    }
                    Toggle("Custom", isOn: $useCustomSearchEngineInstance)
                }
            })
        }
    }
}


struct Instances {
    public let nitter = [
        "nitter.net",
        "nitter.snopyta.org",
        "nitter.42l.fr",
        "nitter.nixnet.services",
        "nitter.13ad.de",
        "nitter.pussthecat.org",
        "nitter.mastodont.cat",
        "nitter.dark.fail",
        "nitter.tedomum.net",
        "nitter.cattube.org",
        "nitter.fdn.fr",
        "nitter.1d4.us",
        "nitter.kavin.rocks",
        "tweet.lambda.dance",
        "nitter.cc",
        "nitter.vxempire.xyz",
        "nitter.unixfox.eu",
        "bird.trom.tf",
    ]
    public let reddit = [
        // libreddit: privacy w/ modern UI
        "libredd.it",
        "libreddit.spike.codes",
        "libreddit.kavin.rocks",
        "libreddit.insanity.wtf",
        "libreddit.dothq.co",
        "libreddit.silkky.cloud",
        "libreddit.himiko.cloud",
        // teddit: privacy w/ old UI
        "teddit.net",
        "teddit.ggc-project.de",
        "teddit.kavin.rocks",
        "old.reddit.com", // desktop
        "i.reddit.com", // mobile
        "snew.notabug.io", // anti-censorship
    ]
    public let invidious = [
        "invidious.snopyta.org",
        "invidious.xyz",
        "invidious.kavin.rocks",
        "tube.connect.cafe",
        "invidious.zapashcanon.fr",
        "invidiou.site",
        "vid.mint.lgbt",
        "invidious.site",
        "yewtu.be",
        "invidious.tube",
        "invidious.silkky.cloud",
        "invidious.fdn.fr",
        "invidious.himiko.cloud",
        "inv.skyn3t.in",
        "tube.incognet.io",
        "invidious.tinfoil-hat.net",
        "invidious.namazso.eu",
        "vid.puffyan.us",
        "dev.viewtube.io",
        "invidious.048596.xyz",
    ]
    public let simplyTranslate = [
        "translate.metalune.xyz",
    ]
    public let maps = [
         "openstreetmap.org"
    ]
    public let searchEngines = [
        SearchEngineInstance("duckduckgo.com"),
        SearchEngineInstance("startpage.com", path: "/search/"),
        SearchEngineInstance("www.ecosia.org", path: "/search"),
        SearchEngineInstance("www.qwant.com"),
        SearchEngineInstance("www.mojeek.com", path: "/search"),
        SearchEngineInstance("search.snopyta.org"),
        SearchEngineInstance("searx.info"),
        SearchEngineInstance("searx.be"),
        SearchEngineInstance("search.disroot.org"),
        SearchEngineInstance("searx.tuxcloud.net"),
        SearchEngineInstance("searx.ninja"),
        SearchEngineInstance("tromland.org/searx", path: "/search"),
        SearchEngineInstance("engine.presearch.org", path: "/search"),
        SearchEngineInstance("searx.silkky.cloud"),
        SearchEngineInstance("search.trom.tf"),
        SearchEngineInstance("whooglesearch.net", path: "/search"),
        SearchEngineInstance("whoogle.sdf.org", path: "/search"),
        SearchEngineInstance("whoogle.himiko.cloud", path: "/search"),
        SearchEngineInstance("whoogle-search.zeet.app", path: "/search"),
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


struct InstancesView_Previews: PreviewProvider {
    static var previews: some View {
        InstancesView()
    }
}
