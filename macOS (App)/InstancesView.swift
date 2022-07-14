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
    @AppStorage("invidiousInstance") var invidiousInstance = "invidious.kavin.rocks"
    @AppStorage("bibliogramInstance") var bibliogramInstance = "bibliogram.art"
    @AppStorage("simplyTranslateInstance") var simplyTranslateInstance = "simplytranslate.org"
    @AppStorage("osmInstance") var osmInstance = "openstreetmap.org"
    @AppStorage("searchEngineInstance") var searchEngineInstance = "duckduckgo.com/"
    @AppStorage("scribeInstance") var scribeInstance = "scribe.rip"
    @AppStorage("proxiTokInstance") var proxiTokInstance = "proxitok.herokuapp.com"
    @AppStorage("rimgoInstance") var rimgoInstance = "i.bcow.xyz"
    
    let instances = Instances()
    
    var body: some View {
        Form {
            InstanceSection(
                name: "Twitter",
                customInstance: $useCustomNitterInstance,
                instance: $nitterInstance,
                instances: instances.nitter)
            InstanceSection(
                name: "Reddit",
                customInstance: $useCustomRedditInstance,
                instance: $redditInstance,
                instances: instances.reddit)
            InstanceSection(
                name: "YouTube",
                customInstance: $useCustomInvidiousInstance,
                instance: $invidiousInstance,
                instances: instances.invidious)
            InstanceSection(
                name: "Instagram",
                customInstance: $useCustomBibliogramInstance,
                instance: $bibliogramInstance,
                instances: instances.bibliogram)
            InstanceSection(
                name: "Google Translate",
                customInstance: $useCustomSimplyTranslateInstance,
                instance: $simplyTranslateInstance,
                instances: instances.simplyTranslate)
            InstanceSection(
                name: "Google Maps",
                customInstance: $useCustomOsmInstance,
                instance: $osmInstance,
                instances: instances.maps)
            Section(header: Text("Google Search").bold(), content: {
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
            InstanceSection(
                name: "Medium",
                customInstance: $useCustomScribeInstance,
                instance: $scribeInstance,
                instances: instances.scribe)
            InstanceSection(
                name: "TikTok",
                customInstance: $useCustomProxiTokInstance,
                instance: $proxiTokInstance,
                instances: instances.proxiTok)
            InstanceSection(
                name: "Imgur",
                customInstance: $useCustomRimgoInstance,
                instance: $rimgoInstance,
                instances: instances.rimgo)
        }
        .labelsHidden()
    }
}

struct InstanceSection: View {
    public let name: String
    public let customInstance: Binding<Bool>
    public let instance: Binding<String>
    public let instances: Array<String>

    var body: some View {
        Section(header: Text(name).bold(), content: {
            HStack {
            if !customInstance.wrappedValue {
                Picker(selection: instance,
                       label: Text("Instance"), content: {
                        ForEach(instances, id: \.self) { instance in
                            Text("\(instance)").tag(instance)
                        }
                })
            } else {
                TextField("\(name) Instance", text: instance)
            }
                Toggle("Custom", isOn: customInstance)
            }
        })
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
