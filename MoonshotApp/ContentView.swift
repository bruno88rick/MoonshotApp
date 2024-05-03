//
//  ContentView.swift
//  MoonshotApp
//
//  Created by Bruno Oliveira on 16/02/24.
//

import SwiftUI

struct ContentView: View {
    
    //@State private var showingGridView = true
    
    @AppStorage("showingGrid") private var showingGridView = true
    
    var body: some View {
        //verifying with the file was loaded correctly:
        //Text("Astronauts \(String(astronauts.count))")
        //Text("Missions \(String(missions.count))")
        NavigationStack {
            MissionsListView(missionViewType: showingGridView ? viewType.grid : viewType.list)
            .toolbar {
                Button {
                    withAnimation(.linear(duration: 0.9)) {
                        showingGridView.toggle()
                    }
                } label: {
                    if showingGridView {
                        Label("Showing as Grid", systemImage: "list.dash")
                    } else {
                        Label("Showing as List", systemImage: "square.grid.2x2")
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
