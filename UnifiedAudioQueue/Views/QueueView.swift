//
//  QueueView.swift
//  UnifiedAudioQueue
//
//  Created by John C. DeLeo on 3/20/24.
//

import Foundation
import SwiftUI

struct SelectedItem {
    var item: UUID?
}

struct QueueView: View {
    @Binding var queue: Queue
    @State var selected = SelectedItem()
    
    var body: some View {
        NavigationStack {
            List(queue.items, id: \.self, selection: $selected.item) { item in
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
                .swipeActions(
                    edge: .trailing
                ) {
                    Button(
                        "",
                        systemImage: "trash"
                    ) {
                        queue.removeItem(
                            itemID: item.id
                        )
                    } .tint(
                        Color.red
                    )
                }
                .swipeActions(
                    edge: .leading
                ) {
                    Button(
                        "",
                        systemImage: "text.line.first.and.arrowtriangle.forward"
                    ) {
                        queue.moveToTop(
                            itemID: item.id
                        )
                    } .tint(
                        Color.blue
                    )
                }
            }   .scrollContentBackground(
                .hidden
            )
            .navigationTitle(
                "Unified Queue"
            )
            .toolbarBackground(
                Color.white,
                for: .navigationBar
            )

        }
    }
         
}
