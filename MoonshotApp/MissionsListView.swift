//
//  MissionsGridView.swift
//  MoonshotApp
//
//  Created by Bruno Oliveira on 28/02/24.
//

import SwiftUI

struct MissionsListView: View {
    var missionViewType = viewType.grid
    let returnDataForView = ReturnDataForViews()
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    @ViewBuilder
    var body: some View {
        
        if missionViewType == viewType.grid {
            NavigationStack {
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(returnDataForView.missions) { mission in
                            NavigationLink {
                                MissionView(mission: mission, astronauts: returnDataForView.astronauts)
                            } label: {
                                VStack {
                                    Image(mission.image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
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
                                    .frame(maxWidth: .infinity)
                                    .background(.lightBackground)
                                }
                                //drawing a line around it and clipping the shape just a little. To get that effect, add these modifiers to the end of it:
                                .clipShape(.rect(cornerRadius: 10))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.lightBackground)
                                )
                            }
                        }
                    }
                    .padding([.horizontal, .bottom])
                }
                .navigationTitle("Moonshot")
                .background(.darkBackground)
                //telling SwiftUI our view prefers to be in dark mode always
                .preferredColorScheme(.dark)
            }
        } else {
            NavigationStack {
                ZStack {
                    Color(.darkBackground)
                        .ignoresSafeArea()
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
                                        if let date = mission.launchDate {
                                            Label(date.formatted(date: .abbreviated, time: .omitted), systemImage: "calendar")
                                                .font(.caption)
                                                .foregroundStyle(.white.opacity(0.5))
                                            //Using a translucent white for the foreground color allows just a hint of the color behind to come through
                                        }
                                    }
                                    .padding(.vertical, 30)
                                    .frame(maxWidth: .infinity)
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
                            //to apply a background color to a list
                            .listRowBackground(Color.darkBackground)
                        }
                    }
                    //to apply the background color of the list to entire view (ether safeArea)
                    .listStyle(.plain)
                }
                .navigationTitle("Moonshot")
                .preferredColorScheme(.dark)
            }
        }
        //telling SwiftUI our view prefers to be in dark mode always
    }
}

#Preview {
    MissionsListView(missionViewType: viewType.grid)
}
