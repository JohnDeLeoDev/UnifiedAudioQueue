//
//  TabBarView.swift
//  UnifiedAudioQueue
//
//  Created by John C. DeLeo on 3/20/24.
//

import Foundation
import SwiftUI

struct TabBarView: View {
    @Binding var selection: Tab
    @Binding var queue: Queue
    
    var body: some View {
        TabView(selection: $selection,
                content:  {
            QueueView(
                queue: $queue
            ).tabItem {
                Image(
                    systemName: "text.line.first.and.arrowtriangle.forward"
                )
            }.tag(
                1
            )
            MusicView(
                queue: $queue
            ).tabItem {
                Image(
                    systemName: "music.note"
                )
            }.tag(
                2
            )
            PodcastsView(
                queue: $queue
            ).tabItem {
                Image(
                    systemName: "mic"
                )
            }.tag(
                3
            )
        }) .onAppear {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}
