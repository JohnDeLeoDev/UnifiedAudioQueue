//
//  MusicView.swift
//  UnifiedAudioQueue
//
//  Created by John C. DeLeo on 3/18/24.
//

import SwiftUI

struct MusicView: View {
    @Binding var queue: Queue
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(
            path: $path
        ) {
            ArtistView(
                queue: $queue
            )
        }
    }
}

struct ArtistView: View {
    @Binding var queue: Queue
    
    var body: some View {
        List(
            queue.musicVM.library.artists
        ) { artist in
            NavigationLink {
                AlbumsView(
                    queue: $queue,
                    artist: artist
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
                            "\(artist.name)"
                        )
                    }) .padding(
                        .leading,
                        10
                    )
                }) .frame(
                    minHeight: 50
                )
            }
        }
        .navigationTitle(
            "Artists"
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

struct AlbumsView: View {
    @Binding var queue: Queue
    var artist: Artist
    
    var body: some View {
        List(
            queue.musicVM.artistAlbums(
                artistID: artist.id
            ) ?? []
        ) { album in
            NavigationLink {
                SongsView(
                    queue: $queue,
                    artist: artist,
                    album: album
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
                            "\(album.name)"
                        )
                        Text(
                            "\(album.releaseDate.formatted(.dateTime.day().month().year()))"
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
                }) .frame(
                    minHeight: 50
                )
            }
            .swipeActions() {
                Button(
                    "",
                    systemImage: "text.line.first.and.arrowtriangle.forward"
                ) {
                    queue.addAlbum(
                        artistID: artist.id,
                        albumID: album.id
                    )
                } .tint(
                    Color.blue
                )
            }
        }         
        .navigationTitle(
            "\(artist.name)"
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


struct SongsView: View {
    @Binding var queue: Queue
    var artist: Artist
    var album: Album
    @State var search: String = ""
    
    var body: some View {
        List(
            queue.musicVM.albumSongs(
                artistID: artist.id,
                albumID: album.id
            ) ?? []
        ) { song in
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
                        "\(song.name)"
                    )
                    Text(
                        "Track \(song.track)"
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
                height:50
            )
            .swipeActions() {
                Button(
                    "",
                    systemImage: "text.line.first.and.arrowtriangle.forward"
                ) {
                    queue.addSong(
                        songID: song.id,
                        songName: song.name,
                        artistID: artist.id,
                        artistName: artist.name
                    )
                } .tint(
                    Color.blue
                )
            }
        }
        .navigationTitle(
            "\(album.name)"
        )
        .scrollContentBackground(
            .hidden
        )
        .toolbarBackground(
            Color.white,
            for: .navigationBar
        )
        .searchable(text: $search)

    }
}
