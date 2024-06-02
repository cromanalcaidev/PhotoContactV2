//
//  ContentView.swift
//  PhotoContactV2
//
//  Created by Carlos Román Alcaide on 1/6/24.
//

import SwiftUI

struct ContentView: View {
    @State private var contacts = Contacts()
    @State private var enableAddContact = false
    @State private var isTapped = false
    
    @State private var isGrid = false
    
    var body: some View {
        if isGrid {
            withAnimation {
                GridView(isGrid: $isGrid)
            }
        } else {
            withAnimation {
                ListView(isGrid: $isGrid)
            }
        }
        
    }
}

#Preview {
    ContentView()
}

