//
//  Queue.swift
//  UnifiedAudioQueue
//
//  Created by John C. DeLeo on 3/20/24.
//

import Foundation
import SwiftUI

struct Queue: Hashable, Identifiable, Equatable {
    var id: ObjectIdentifier
    
    var queueID: UUID
    var items: [Item]
    var musicVM: MusicVM
    var podcastsVM: PodcastsVM
    var allItems: [Item]
    
    init() {
        self.items = []
        self.queueID = UUID()
        self.musicVM = MusicVM()
        self.podcastsVM = PodcastsVM()
        self.id = ObjectIdentifier(
            Queue.self
            )
        self.allItems = []
        self.setupSearch()
    }
    
    static func == (
        lhs: Queue,
        rhs: Queue
    ) -> Bool {
        lhs.id == rhs.id && lhs.queueID == rhs.queueID && lhs.items == rhs.items && lhs.musicVM == rhs.musicVM && lhs.podcastsVM == rhs.podcastsVM
    }
    
    func hash(
        into hasher: inout Hasher
    ) {
        hasher.combine(
            queueID
        )
    }
    
    mutating func setupSearch() {
        for artist in self.musicVM.library.artists {
            self.allItems.append(Item(id: artist.id, type: "Artist", name: artist.name, parentID: nil, parentName: nil))
            print(self.allItems)
            for album in artist.albums {
                self.allItems.append(Item(id: album.id, type: "Album", name: album.name, parentID: artist.id, parentName: artist.name))
                for song in album.songs {
                    self.allItems.append(Item(id: song.id, type: "Song", name: song.name, parentID: album.id, parentName: album.name))
                }
            }
             
        }
        for podcast in self.podcastsVM.library.podcasts {
            self.allItems.append(Item(id: podcast.id, type: "Podcast", name: podcast.name, parentID: UUID(), parentName: ""))
            /*
            for episode in podcast.episodes {
                self.allItems.append(Item(id: episode.id, type: "Episode", name: episode.name, parentID: podcast.id, parentName: podcast.name))
            }
             */
        }
    }
    
    func search(searchString: String) -> [Item] {
        var results: [Item] = []
        for item in self.allItems {
            if item.name.contains(searchString) {
                results.append(item)
            }
        }

        return results
    }
    
    
    mutating func addSong(
        songID: UUID,
        songName: String,
        artistID: UUID,
        artistName: String
    ) {
        items.append(
            Item(
                id: songID,
                type: "Song",
                name: songName,
                parentID: artistID,
                parentName: artistName
            )
        )
    }
    
    mutating func addAlbum(
        artistID: UUID,
        albumID: UUID
    ) {
        let localAlbum = musicVM.getAlbum(
            artistID: artistID,
            albumID: albumID
        )
        let artist = musicVM.getArtistName(
            artistID: artistID
        ) ?? ""
        
        if let a = localAlbum {
            for song in a.songs {
                items.append(
                    Item(
                        id: song.id,
                        type: "Song",
                        name: song.name,
                        parentID: artistID,
                        parentName: artist
                    )
                )
            }
        }
    }
    
    mutating func addEpisode(
        episodeID: UUID,
        episodeName: String,
        podcastName: String,
        podcastID: UUID
    ) {
        items.append(
            Item(
                id: episodeID,
                type: "Episode",
                name: episodeName,
                parentID: podcastID,
                parentName: podcastName
            )
        )
    }
    
    mutating func addPodcastEpisodes(
        podcastID: UUID
    ) {
        let localEpisodes = podcastsVM.podcastEpisodes(
            podcastID: podcastID
        )
        let podcastName = podcastsVM.getPodcastName(
            podcastID: podcastID
        ) ?? ""
        if let e = localEpisodes {
            for episode in e {
                items.append(
                    Item(
                        id: episode.id,
                        type: "Episode",
                        name: episode.name,
                        parentID: podcastID,
                        parentName: podcastName
                    )
                )
            }
        }
    }
    
    mutating func removeItem(
        itemID: UUID
    ) {
        var localItems = self.items
        var index: Int?
        for item in localItems {
            if item.id == itemID {
                index = localItems.firstIndex(
                    of: item
                )
            }
        }
        if let i = index {
            localItems.remove(
                at: i
            )
        }
        self.items = localItems
        print(
            self.items
        )
    }
    
    mutating func moveToTop(itemID: UUID) {
        var localItems = self.items
        var index: Int?
        var element: Item?
        
        for item in localItems {
            if item.id == itemID {
                index = localItems.firstIndex(
                    of: item
                )
            }
        }
        if let i = index {
            element = localItems.remove(
                at: i
            )
        }
        if let e = element {
            localItems.insert(e, at: 0)
            self.items = localItems
        }
    }
}

struct Item: Hashable, Identifiable, Equatable {
    var id: UUID
    var parentID: UUID
    var type: String
    var name: String
    var parentName: String
    
    init(
        id: UUID,
        type: String,
        name: String,
        parentID: UUID?,
        parentName: String?
    ) {
        self.id = id
        self.type = type
        self.name = name
        self.parentID = parentID ?? UUID()
        self.parentName = parentName ?? ""
    }
    
    static func == (
        lhs: Item,
        rhs: Item
    ) -> Bool {
        lhs.id == rhs.id && lhs.type == rhs.type && lhs.name == rhs.name && lhs.parentName == rhs.parentName && lhs.parentID == rhs.parentID
    }
    
    func hash(
        into hasher: inout Hasher
    ) {
        hasher.combine(
            id
        )
    }
}


