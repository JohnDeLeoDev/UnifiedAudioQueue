//
//  NavigationView.swift
//  UnifiedAudioQueue
//
//  Created by John C. DeLeo on 3/18/24.
//

import SwiftUI

struct TopNavigation: View {
    @Binding var menuState: Bool
       
    @ViewBuilder
    var body: some View {
        HStack {
            Button(
                action: {
                    menuState.toggle()
                },
                label: {
                    Image(systemName: "line.3.horizontal")
                }
            )
            
            Spacer()
            
            Button(
                action: {
                    
                },
                label: {
                    Image(systemName: "magnifyingglass")
                }
            )
        }
    }
}
    
    
    

