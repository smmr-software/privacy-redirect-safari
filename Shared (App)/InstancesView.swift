//
//  InstancesView.swift
//  Privacy Redirect for Safari
//
//  Created by figbert on 15/7/22.
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
        InstanceViewContainer {
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
            #if os(iOS)
            VStack(alignment: .leading) {
                Text("Google Search")
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
            #else
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
            #endif
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
    }
}

struct InstancesView_Previews: PreviewProvider {
    static var previews: some View {
        InstancesView()
    }
}
