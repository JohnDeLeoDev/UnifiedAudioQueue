//
//  MusicVM.swift
//  UnifiedAudioQueue
//
//  Created by John C. DeLeo on 3/18/24.
//

import Foundation

struct MusicVM: Hashable, Identifiable, Equatable {
    var id: ObjectIdentifier
    
    var libID: UUID
    var library : MusicLibrary
    
    init(
        library: MusicLibrary = MusicLibrary()
    ) {
        self.library = library
        self.libID = UUID()
        self.id = ObjectIdentifier(
            MusicVM.self
        )
    }
    
    func returnArtists() -> [Artist] {
        return self.library.artists
    }
    
    func artistAlbums(
        artistID: UUID
    ) -> [Album]? {
        for localArtist in self.library.artists {
            if artistID == localArtist.id {
                return localArtist.albums
            }
        }
        return nil
    }
    
    func albumSongs(
        artistID: UUID,
        albumID: UUID
    ) -> [Song]? {
        var artist: Artist?
        
        for localArtist in self.library.artists {
            if artistID == localArtist.id {
                artist = localArtist
            }
        }
        if let a =  artist {
            for localAlbum in a.albums {
                if albumID == localAlbum.id {
                    return localAlbum.songs
                }
            }
        }
        return nil
    }
    
    static func == (
        lhs: MusicVM,
        rhs: MusicVM
    ) -> Bool {
        lhs.libID == rhs.libID && lhs.library == rhs.library && lhs.id == rhs.id
    }
    
    func hash(
        into hasher: inout Hasher
    ) {
        hasher.combine(
            libID
        )
    }
    
    func getArtist(
        artistID: UUID
    ) -> Artist? {
        for localArtist in self.library.artists {
            if localArtist.id == artistID {
                return localArtist
            }
        }
        return nil
    }
    
    func getAlbum(
        artistID: UUID,
        albumID: UUID
    ) -> Album? {
        let localArtist = self.getArtist(
            artistID: artistID
        )
        
        if let a = localArtist {
            for localAlbum in a.albums {
                if localAlbum.id == albumID {
                    return localAlbum
                }
            }
        }
        return nil
    }
    
    func getArtistName(
        artistID: UUID
    ) -> String? {
        for localArtist in self.library.artists {
            if localArtist.id == artistID {
                return localArtist.name
            }
        }
        return nil
    }
    
    func getAlbumName(
        artistID: UUID,
        albumID: UUID
    ) -> String? {
        var artist: Artist?
        
        for localArtist in self.library.artists {
            if localArtist.id == artistID {
                artist = localArtist
            }
        }
        
        if let a = artist {
            for localAlbum in a.albums {
                if localAlbum.id == albumID {
                    return localAlbum.name
                }
            }
        }
        return nil
    }
}




struct MusicLibrary: Hashable, Identifiable, Equatable {
    var artists: [Artist]
    var id: UUID
    
    init(
        artists: [Artist] = []
    ) {
        self.id = UUID()
        self.artists = artists
        self.fakeArtists()
    }
    
    mutating func fakeArtists() {
        var albums: [Album] = []
        var songs: [Song] = []
        
        
        for i in 1...20 {
            songs.append(
                Song(
                    name: "Song #\(i)",
                    track: i
                )
            )
        }
        
        
        for i in 1...5 {
            albums.append(
                Album(
                    name: "Album #\(i)",
                    releaseDate: Date(),
                    songs: songs
                )
            )
        }
        
        
        for i in 1...100 {
            self.artists.append(
                Artist(
                    name: "Artist #\(i)",
                    albums: albums
                )
            )
        }
        
        print(
            self.artists
        )
    }
    
    static func == (
        lhs: MusicLibrary,
        rhs: MusicLibrary
    ) -> Bool {
        lhs.id == rhs.id && lhs.artists == rhs.artists
    }
    
    func hash(
        into hasher: inout Hasher
    ) {
        hasher.combine(
            id
        )
    }
    
    
}

struct Artist: Identifiable, Hashable, Equatable {
    var id: UUID
    var name: String = ""
    var albums: [Album]
    
    
    init(
        name: String = "",
        albums: [Album]
    ) {
        self.id = UUID()
        self.name = name
        self.albums = albums
    }
    
    func hash(
        into hasher: inout Hasher
    ) {
        hasher.combine(
            id
        )
    }
    
    static func == (
        lhs: Artist,
        rhs: Artist
    ) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.albums == rhs.albums
    }
}

struct Album: Identifiable, Hashable, Equatable {
    var id: UUID
    var name: String
    var releaseDate: Date
    var songs: [Song]
    
    init(
        name: String,
        releaseDate: Date,
        songs: [Song]
    ) {
        self.id = UUID()
        self.name = name
        self.releaseDate = releaseDate
        self.songs = songs
    }
    
    func hash(
        into hasher: inout Hasher
    ) {
        hasher.combine(
            id
        )
    }
    
    static func == (
        lhs : Album,
        rhs: Album
    ) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.releaseDate == rhs.releaseDate && lhs.songs == rhs.songs
    }
}

struct Song: Identifiable, Hashable, Equatable {
    var id: UUID
    var name: String
    var track: Int
    
    init(
        name: String,
        track: Int
    ) {
        self.id = UUID()
        self.name = name
        self.track = track
    }
    
    func hash(
        into hasher: inout Hasher
    ) {
        hasher.combine(
            id
        )
    }
    
    static func == (
        lhs : Song,
        rhs: Song
    ) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.track == rhs.track
    }
}








