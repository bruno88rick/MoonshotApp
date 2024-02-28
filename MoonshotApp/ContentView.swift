//
//  ContentView.swift
//  MoonshotApp
//
//  Created by Bruno Oliveira on 16/02/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingGridView = true
    
    var body: some View {
        //verifying with the file was loaded correctly:
        //Text("Astronauts \(String(astronauts.count))")
        //Text("Missions \(String(missions.count))")
        
        NavigationStack {
            MissionsGridView()
                .navigationTitle("Moonshot")
                .background(.darkBackground)
                //telling SwiftUI our view prefers to be in dark mode always
                .preferredColorScheme(.dark)
            
            .toolbar {
                Button {
                    showingGridView.toggle()
                } label: {
                    if !showingGridView {
                        Image(systemName: "square.grid.2x2")
                    } else {
                        Image(systemName: "list.bullet")
                    }
                }
            }
        }
        
    }
}

#Preview {
    ContentView()
}
