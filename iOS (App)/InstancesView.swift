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
    @AppStorage("useCustomScribeInstance") var useCustomScribeInstance = false
    
    @AppStorage("nitterInstance") var nitterInstance = "nitter.net"
    @AppStorage("redditInstance") var redditInstance = "teddit.net"
    @AppStorage("invidiousInstance") var invidiousInstance = "invidious.snopyta.org"
    @AppStorage("simplyTranslateInstance") var simplyTranslateInstance = "translate.metalune.xyz"
    @AppStorage("osmInstance") var osmInstance = "openstreetmap.org"
    @AppStorage("searchEngineInstance") var searchEngineInstance = "duckduckgo.com/"
    @AppStorage("scribeInstance") var scribeInstance = "scribe.rip"
    
    let instances = Instances()
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Nitter")
                    .font(.headline)
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
                    Spacer()
                    Toggle("Custom", isOn: $useCustomNitterInstance)
                        .labelsHidden()
                }
            }
            VStack {
                VStack(alignment: .leading) {
                    Text("Teddit or Libreddit")
                        .font(.headline)
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
                        Spacer()
                        Toggle("Custom", isOn: $useCustomRedditInstance)
                            .labelsHidden()
                    }
                }
            }
            VStack {
                VStack(alignment: .leading) {
                    Text("Invidious")
                        .font(.headline)
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
                        Spacer()
                        Toggle("Custom", isOn: $useCustomInvidiousInstance)
                            .labelsHidden()
                    }
                }
            }
            VStack {
                VStack(alignment: .leading) {
                    Text("SimplyTranslate")
                        .font(.headline)
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
                        Spacer()
                        Toggle("Custom", isOn: $useCustomSimplyTranslateInstance)
                            .labelsHidden()
                    }
                }
            }
            VStack {
                VStack(alignment: .leading) {
                    Text("OpenStreetMap")
                        .font(.headline)
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
                        Spacer()
                        Toggle("Custom", isOn: $useCustomOsmInstance)
                            .labelsHidden()
                    }
                }
            }
            VStack {
                VStack(alignment: .leading) {
                    Text("Search Engine")
                        .font(.headline)
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
                        Spacer()
                        Toggle("Custom", isOn: $useCustomSearchEngineInstance)
                            .labelsHidden()
                    }
                }
            }
            VStack {
                VStack(alignment: .leading) {
                    Text("Medium")
                        .font(.headline)
                    HStack {
                        if !useCustomScribeInstance {
                            Picker(selection: $scribeInstance,
                                   label: Text("Instance"), content: {
                                    ForEach(instances.scribe, id: \.self) { instance in
                                        Text("\(instance)").tag(instance)
                                    }
                            })
                                .labelsHidden()
                        } else {
                            TextField("Scribe Instance", text: $scribeInstance)
                        }
                        Spacer()
                        Toggle("Custom", isOn: $useCustomScribeInstance)
                            .labelsHidden()
                    }
                }
            }
        }
        .frame(maxWidth: 600)
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
        SearchEngineInstance("whoogle.himiko.cloud", path: "/search"),
    ]
    public let scribe = [
        "scribe.rip",
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
