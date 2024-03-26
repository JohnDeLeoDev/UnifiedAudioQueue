//
//  Podcasts.swift
//  UnifiedAudioQueue
//
//  Created by John C. DeLeo on 3/18/24.
//

import SwiftUI

struct PodcastsVM: Identifiable, Equatable {
    var id = UUID()
    var library: PodcastLibrary
    
    init(
        library: PodcastLibrary = PodcastLibrary()
    ) {
        self.library = library
        self.id = UUID()
    }
    
    func returnPodcasts() -> [Podcast] {
        return self.library.podcasts
    }
    
    func podcastEpisodes(
        podcastID: UUID
    ) -> [Episode]? {
        for localPodcast in self.library.podcasts {
            if podcastID == localPodcast.id {
                return localPodcast.episodes
            }
        }
        return nil
    }
    
    func getPodcast(
        podcastID: UUID
    ) -> Podcast? {
        for localPodcast in self.library.podcasts {
            if localPodcast.id == podcastID {
                return localPodcast
            }
        }
        return nil
    }
    
    func getPodcastName(
        podcastID: UUID
    ) -> String? {
        for localPodcast in self.library.podcasts {
            if localPodcast.id == podcastID {
                return localPodcast.name
            }
        }
        return nil
    }
    
    func getEpisodeName(
        podcastID: UUID,
        episodeID: UUID
    ) -> String? {
        var podcast: Podcast?
        
        for localPodcast in self.library.podcasts {
            if localPodcast.id == podcastID {
                podcast = localPodcast
            }
        }
        
        if let p = podcast {
            for localEpisode in p.episodes {
                if localEpisode.id == episodeID {
                    return localEpisode.name
                }
            }
        }
        
        
        return nil
    }
    
    static func == (
        lhs: PodcastsVM,
        rhs: PodcastsVM
    ) -> Bool {
        lhs.id == rhs.id && lhs.library == rhs.library
    }
    
    func hash(
        into hasher: inout Hasher
    ) {
        hasher.combine(
            id
        )
    }
    
    
}

struct PodcastLibrary: Identifiable, Hashable, Equatable {
    var podcasts: [Podcast]
    var id: UUID
    
    init(
        podcasts: [Podcast] = []
    ) {
        self.id = UUID()
        self.podcasts = podcasts
        self.fakePodcasts()
    }
    
    mutating func fakePodcasts() {
        var localPodcasts: [Podcast] = []
        var localEpisodes: [Episode] = []
        
        for i in 1...100 {
            localEpisodes.append(
                Episode(
                    name: "Episode #\(i)",
                    releaseDate: Date(),
                    length: TimeInterval()
                )
            )
        }
        
        for i in 1...29 {
            localPodcasts.append(
                Podcast(
                    name: "Podcast #\(i)",
                    episodes: localEpisodes
                )
            )
        }
        
        podcasts = localPodcasts
    }
    
    static func == (
        lhs: PodcastLibrary,
        rhs: PodcastLibrary
    ) -> Bool {
        lhs.id == rhs.id && lhs.podcasts == rhs.podcasts
    }
    
    func hash(
        into hasher: inout Hasher
    ) {
        hasher.combine(
            id
        )
    }
}




struct Podcast: Identifiable, Hashable, Equatable {
    let id: UUID
    var name: String
    var episodes: [Episode]
    
    init(
        name: String,
        episodes: [Episode]
    ) {
        self.id = UUID()
        self.name = name
        self.episodes = episodes
    }
    
    func hash(
        into hasher: inout Hasher
    ) {
        hasher.combine(
            id
        )
    }
    
    static func == (
        lhs: Podcast,
        rhs: Podcast
    ) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.episodes == rhs.episodes
    }
    
}


struct Episode: Identifiable, Hashable, Equatable {
    let id: UUID
    var name: String
    var releaseDate: Date
    var length: TimeInterval
    
    init(
        name: String,
        releaseDate: Date,
        length: TimeInterval
    ) {
        self.id = UUID()
        self.name = name
        self.releaseDate = releaseDate
        self.length = length
    }
    
    func hash(
        into hasher: inout Hasher
    ) {
        hasher.combine(
            id
        )
    }
    
    static func == (
        lhs: Episode,
        rhs: Episode
    ) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.releaseDate == rhs.releaseDate && lhs.length == rhs.length
    }
}
