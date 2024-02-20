//
//  ContentView.swift
//  MoonshotApp
//
//  Created by Bruno Oliveira on 16/02/24.
//

import SwiftUI

struct ContentView: View {
    
    //all we’ve done is just moved code out of ContentView and into an extension (see Bundle-Decodable), but there’s nothing wrong with that – anything we can do to help our views stay small and focused is a good thing
    
    //“Generic parameter 'T' could not be inferred”, over in the astronauts property of ContentView. This line worked fine before, but there has been an important change now: before decode() would always return a dictionary of astronauts, but now it returns anything we want as long as it conforms to Codable. We know it will still return a dictionary of astronauts because the actual underlying data hasn’t changed, but Swift doesn’t know that. Our problem is that decode() can return any type that conforms to Codable, but Swift needs more information – it wants to know exactly what type it will be. Try deleting the type on the constant astronauts. "[String: Astronaut] ou from missions too to see the error. Deleting this works well if we're not decoding and returning generics<T> types. So, to use with geneics we need to use a type annotation so Swift knows exactly what astronauts will be
    
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        //verifying with the file was loaded correctly:
        //Text("Astronauts \(String(astronauts.count))")
        //Text("Missions \(String(missions.count))")
        
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(missions) { mission in
                        NavigationLink {
                            MissionView(mission: mission, astronauts: astronauts)
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
        
    }
}

#Preview {
    ContentView()
}
