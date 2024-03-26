//
//  ContentView.swift
//  UnifiedAudioQueue
//
//  Created by John C. DeLeo on 3/18/24.
//

import SwiftUI

enum Tab {
    case queue
    case music
    case podcasts
}

struct ContentView: View {
    @State var selection: Tab = .queue
    @State var showMenu: Bool = false
    @State var queue: Queue = Queue()
    @State var showSettings: Bool = false

    @ViewBuilder
    var body: some View {
        ZStack{
            NavigationStack {
                
                VStack {
                    HStack{
                        NavigationLink {
                            SettingsView()
                        } label: {
                            Image(
                                systemName: "gearshape"
                            )
                        } .font(.title)
                            .padding(.leading)
                        Spacer()
                        
                        NavigationLink {
                            SearchView(queue: $queue)
                                .navigationTitle("Search")

                        } label: {
                            Image(
                                systemName: "magnifyingglass"
                            )
                        } .font(.title)
                            .padding(.trailing)
                    }
                    /*
                     Button {
                     showSettings.toggle()
                     } label: {
                     Image(
                     systemName: "gearshape"
                     )
                     }   .font(
                     /*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/
                     )
                     .padding(
                     .leading
                     )
                     
                     Spacer()
                     Button {
                     
                     } label: {
                     Image(
                     systemName: "magnifyingglass"
                     )
                     }   .font(
                     /*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/
                     )
                     .padding(
                     .trailing
                     )
                     */
                }
                TabBarView(
                    selection: $selection,
                    queue: $queue
                )
            }
            MenuView(
                isShowing: $showMenu
            )
        }
    
    }
}


#Preview {
    ContentView()
}
