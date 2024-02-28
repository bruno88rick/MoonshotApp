//
//  MissionView.swift
//  MoonshotApp
//
//  Created by Bruno Oliveira on 20/02/24.
//

import SwiftUI

struct MissionView: View {
    
    //nested struct
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    
    //property to MissionView that stores an array of CrewMember objects – these are the fully resolved role / astronaut pairings
    let crew: [CrewMember]
    
    var body: some View {
        
        ScrollView {
            VStack {
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { width, axis in
                        width * 0.6
                    }
                    .padding(.top)
                
                HStack {
                    Text("Launch Date: ")
                        .font(.caption.bold())
                        .foregroundStyle(.white)
                    Text(mission.formattedLauchDate)
                        .font(.caption)
                        .foregroundStyle(.white)
                }
                .padding(.horizontal, 3)
                
                VStack(alignment: .leading) {

                    //built in Divider() or a custom one
                    //Divider()
                    RectangleDivider()

                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                    
                    Text(mission.description)
                    
                    RectangleDivider()
                    
                    Text("Crew")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                }
                .padding(.horizontal)
                
                //Bar indicator off: showsIndicators: false
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(crew, id: \.role) { crewMember in
                            NavigationLink {
                                AstronautView(astronaut: crewMember.astronaut)
                            } label: {
                                HStack {
                                    Image(crewMember.astronaut.id)
                                        .resizable()
                                        .frame(width: 104, height: 72)
                                        .clipShape(.capsule)
                                        .overlay(
                                            Capsule()
                                                .strokeBorder(.white, lineWidth: 1)
                                        )
                                    
                                    VStack(alignment: .leading) {
                                        Text(crewMember.astronaut.name)
                                            .foregroundStyle(.white)
                                            .font(.headline)
                                        Text(crewMember.role)
                                            .foregroundStyle(.white.opacity(0.5))
                                    }
                                    .padding(.horizontal)
                                }
                                
                            }
                        }
                    }
                }
            }
            .padding(.bottom)
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
        
        //Placing a VStack inside another VStack allows us to control alignment for one specific part of our view – our main mission image can be centered, while the mission details can be aligned to the leading edge.
    }
    
    /*But then how do we set that property? Well, think about it: if we make this view be handed its mission and all astronauts, we can loop over the mission crew, then for each crew member look in the dictionary to find the one that has a matching ID. When we find one we can convert that and their role into a CrewMember object, but if we don’t it means somehow we have a crew role with an invalid or unknown name.
     
     That latter case should never happen. To be clear, if you’ve added some JSON to your project that points to missing data in your app, you’ve made a fundamental mistake – it’s not the kind of thing you should try to write error handling for at runtime, because it should never be allowed to happen in the first place. So, this is a great example of where fatalError() is useful: if we can’t find an astronaut using their ID, we should exit immediately and complain loudly.

     Let’s put all that into code, using a custom initializer for MissionView*/
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Mission \(member.name)")
            }
        }
    }
}

#Preview {
    //that thing needs a Mission object passed in so it has something to render. Fortunately, our Bundle extension is available here as well:
    
    let missions: [Mission]  = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    return MissionView(mission: missions[0], astronauts: astronauts)
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        //This view will automatically have a dark color scheme because it’s applied to the NavigationStack in ContentView, but the MissionView preview doesn’t know that so we need to enable it by hand
}
