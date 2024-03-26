//
//  SearchView.swift
//  UnifiedAudioQueue
//
//  Created by John C. DeLeo on 3/22/24.
//

import Foundation
import SwiftUI

struct SearchView: View {
    @State var searchField: String = ""
    @State var searchResults: [Item] = []
    @Binding var queue: Queue
    
    var body: some View {
        VStack(content: {
            List(searchResults) { item in
                HStack(content: {
                    Rectangle().frame(
                        width: 40,
                        height: 40
                    ).background(
                        Color.gray
                    )
                    VStack(content: {
                        Text(
                            "\(item.name)"
                        )
                        .padding(
                            .leading,
                            10
                        )
                        Text(
                            "\(item.parentName)"
                        )
                        .foregroundStyle(
                            Color.gray
                        )
                        .font(
                            .caption
                        )
                    })
                })
                .frame(
                    height:50
                )
            }
            .searchable(text: $searchField)
            .scrollContentBackground(
                .hidden
            )
            .onSubmit(of: .search) {
                searchResults = queue.search(searchString: searchField)
                }
            Spacer()
        })
    }
}
