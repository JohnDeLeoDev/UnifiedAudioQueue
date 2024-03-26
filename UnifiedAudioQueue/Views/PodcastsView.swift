//
//  PodcastView.swift
//  UnifiedAudioQueue
//
//  Created by John C. DeLeo on 3/18/24.
//

import SwiftUI



struct PodcastsView: View {
    @Binding var queue: Queue
    @State var path = NavigationPath()
    
    var body: some View {
        NavigationStack(
            path: $path
        ) {
            PodcastView(
                queue: $queue
            )
        }
        
    }
}


struct PodcastView: View {
    @Binding var queue: Queue
    
    var body: some View {
        List(
            queue.podcastsVM.library.podcasts
        ) { podcast in
            NavigationLink {
                EpisodeView(
                    queue: $queue,
                    podcast: podcast
                )
            } label: {
                HStack(content: {
                    Rectangle().frame(
                        width: 40,
                        height: 40
                    ).background(
                        Color.gray
                    )
                    VStack(alignment: .leading,
                           content: {
                        Text(
                            "\(podcast.name)"
                        )
                    }) .padding(
                        .leading,
                        10
                    )
                }).frame(
                    height:50
                )
            }
        }
        .navigationTitle(
            "Podcasts"
        )
        .scrollContentBackground(
            .hidden
        )
        .toolbarBackground(
            Color.white,
            for: .navigationBar
        )
    }
}


struct EpisodeView: View {
    @Binding var queue: Queue
    var podcast: Podcast
    
    var body: some View {
        List(
            queue.podcastsVM.podcastEpisodes(
                podcastID: podcast.id
            ) ?? []
        ) { episode in
            HStack(content: {
                Rectangle().frame(
                    width: 40,
                    height: 40
                ).background(
                    Color.gray
                )
                VStack(alignment: .leading,
                       content: {
                    Text(
                        "\(episode.name)"
                    )
                    Text(
                        "\(episode.releaseDate.formatted(.dateTime.day().month().year()))"
                    )
                    .foregroundStyle(
                        Color.gray
                    )
                    .font(
                        .caption
                    )
                }) .padding(
                    .leading,
                    10
                )
            }).frame(
                minHeight: 50
            )
            .swipeActions() {
                Button(
                    "",
                    systemImage: "text.line.first.and.arrowtriangle.forward"
                ) {
                    queue.addEpisode(
                        episodeID: episode.id,
                        episodeName: episode.name,
                        podcastName: podcast.name,
                        podcastID: podcast.id
                    )
                }.tint(
                    Color.blue
                )
                
            }
        }
        .navigationTitle(
            "\(podcast.name)"
        )
        .scrollContentBackground(
            .hidden
        )
        .toolbarBackground(
            Color.white,
            for: .navigationBar
        )
    }
}
