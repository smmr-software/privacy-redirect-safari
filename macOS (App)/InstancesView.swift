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
        SearchEngineInstance("searx.info"),
        SearchEngineInstance("searx.tuxcloud.net"),
        SearchEngineInstance("whoogle.sdf.org", path: "/search"),
        SearchEngineInstance("whoogle.himiko.cloud", path: "/search"),
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
