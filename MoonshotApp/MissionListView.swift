//
//  MissionListView.swift
//  MoonshotApp
//
//  Created by Bruno Oliveira on 29/02/24.
//

import SwiftUI

struct MissionListView: View {
    
    @State private var returnDataForView = ReturnDataForViews()
    
    var body: some View {
        List {
            ForEach(returnDataForView.missions) { mission in
                NavigationLink {
                    MissionView(mission: mission, astronauts: returnDataForView.astronauts)
                } label: {
                    HStack {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .padding()
                        
                        VStack {
                            Text(mission.displayName)
                                .font(.headline)
                                .foregroundStyle(.white)
                            Text(mission.formattedLauchDate)
                                .font(.caption)
                                .foregroundStyle(.white.opacity(0.5))
                                //Using a translucent white for the foreground color allows just a hint of the color behind to come through
                        }
                        .padding(.vertical)
                        .frame(maxWidth: 300)
                        .background(.lightBackground)
                    }
                    //drawing a line around it and clipping the shape just a little. To get that effect, add these modifiers to the end of it:
                    .clipShape(.rect(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.lightBackground)
                    )
                }
                .padding([.horizontal])
            }
        }
    }
}

#Preview {
    MissionListView()
}
