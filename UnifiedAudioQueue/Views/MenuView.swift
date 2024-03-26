//
//  MenuView.swift
//  UnifiedAudioQueue
//
//  Created by John C. DeLeo on 3/20/24.
//

import Foundation
import SwiftUI


struct MenuItems: View {
    var body: some View {
        HStack{
            ZStack{
                Rectangle()
                    .fill(
                        .white
                    )
                    .frame(
                        width: 270
                    )
                    .shadow(
                        color: .purple.opacity(
                            0.1
                        ),
                        radius: 5,
                        x:0,
                        y: 3
                    )
                
                
                VStack() {
                    Text(
                        "UnifiedQueue"
                    )
                    .font(
                        .title
                    )
                    .padding(
                        .bottom,
                        50
                    )
                    Section {
                        Text(
                            "Menu Item 2"
                        )
                        Text(
                            "Menu Item 3"
                        )
                    }
                    
                    Spacer()
                }
                Spacer()
            }
            .padding(
                .top,
                100
            )
            .frame(
                width: 270
            )
            .background(
                Color.white
            )
            Spacer()
        }
        .background(
            .clear
        )
    }
}



struct MenuView: View {
    
    @Binding var isShowing: Bool
    
    var content: AnyView = AnyView(
        MenuItems()
    )
    var edgeTransition: AnyTransition = .move(
        edge: .leading
    )
    
    var body: some View {
        ZStack(
            alignment: .bottom
        ) {
            if (
                isShowing
            ) {
                Color.black
                    .opacity(
                        0.3
                    )
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShowing.toggle()
                    }
                content
                    .transition(
                        edgeTransition
                    )
                    .background(
                        Color.clear
                    )
            }
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .bottom
        )
        .ignoresSafeArea()
        .animation(
            .easeInOut,
            value: isShowing
        )
    }
        
}
