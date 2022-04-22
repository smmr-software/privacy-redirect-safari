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
    @AppStorage("useCustomBibliogramInstance") var useCustomBibliogramInstance = false
    @AppStorage("useCustomSimplyTranslateInstance") var useCustomSimplyTranslateInstance = false
    @AppStorage("useCustomOsmInstance") var useCustomOsmInstance = false
    @AppStorage("useCustomSearchEngineInstance") var useCustomSearchEngineInstance = false
    @AppStorage("useCustomScribeInstance") var useCustomScribeInstance = false
    @AppStorage("useCustomProxiTokInstance") var useCustomProxiTokInstance = false
    @AppStorage("useCustomRimgoInstance") var useCustomRimgoInstance = false
    
    @AppStorage("nitterInstance") var nitterInstance = "nitter.net"
    @AppStorage("redditInstance") var redditInstance = "teddit.net"
    @AppStorage("invidiousInstance") var invidiousInstance = "invidious.snopyta.org"
    @AppStorage("bibliogramInstance") var bibliogramInstance = "bibliogram.art"
    @AppStorage("simplyTranslateInstance") var simplyTranslateInstance = "translate.metalune.xyz"
    @AppStorage("osmInstance") var osmInstance = "openstreetmap.org"
    @AppStorage("searchEngineInstance") var searchEngineInstance = "duckduckgo.com/"
    @AppStorage("scribeInstance") var scribeInstance = "scribe.rip"
    @AppStorage("proxiTokInstance") var proxiTokInstance = "proxitok.herokuapp.com"
    @AppStorage("rimgoInstance") var rimgoInstance = ""
    
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
                    } else {
                        TextField("Invidious Instance", text: $invidiousInstance)
                    }
                    Toggle("Custom", isOn: $useCustomInvidiousInstance)
                }
            })
            Section(header: Text("Bibliogram").bold(), content: {
                HStack {
                    if !useCustomBibliogramInstance {
                        Picker(selection: $bibliogramInstance,
                               label: Text("Instance"), content: {
                                ForEach(instances.bibliogram, id: \.self) { instance in
                                    Text("\(instance)").tag(instance)
                                }
                        })
                    } else {
                        TextField("Bibliogram Instance", text: $bibliogramInstance)
                    }
                    Toggle("Custom", isOn: $useCustomBibliogramInstance)
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
                    } else {
                        TextField("Search Engine Instance (including path)", text: $searchEngineInstance)
                    }
                    Toggle("Custom", isOn: $useCustomSearchEngineInstance)
                }
            })
            Section(header: Text("Medium").bold(), content: {
                HStack {
                    if !useCustomScribeInstance {
                        Picker(selection: $scribeInstance,
                               label: Text("Instance"), content: {
                                ForEach(instances.scribe, id: \.self) { instance in
                                    Text("\(instance)").tag(instance)
                               }
                        })
                    } else {
                        TextField("Scribe Instance", text: $scribeInstance)
                    }
                    Toggle("Custom", isOn: $useCustomScribeInstance)
                }
            })
            Section(header: Text("TikTok").bold(), content: {
                HStack {
                    if !useCustomProxiTokInstance {
                        Picker(selection: $proxiTokInstance,
                               label: Text("Instance"), content: {
                                ForEach(instances.proxiTok, id: \.self) { instance in
                                    Text("\(instance)").tag(instance)
                               }
                        })
                    } else {
                        TextField("ProxiTok Instance", text: $proxiTokInstance)
                    }
                    Toggle("Custom", isOn: $useCustomProxiTokInstance)
                }
            })
            Section(header: Text("Imgur").bold(), content: {
                HStack {
                    if !useCustomRimgoInstance {
                        Picker(selection: $rimgoInstance,
                               label: Text("Instance"), content: {
                                ForEach(instances.rimgo, id: \.self) { instance in
                                    Text("\(instance)").tag(instance)
                               }
                        })
                    } else {
                        TextField("Rimgo Instance", text: $rimgoInstance)
                    }
                    Toggle("Custom", isOn: $useCustomRimgoInstance)
                }
            })
        }
        .labelsHidden()
    }
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
