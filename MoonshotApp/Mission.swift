//
//  Mission.swift
//  MoonshotApp
//
//  Created by Bruno Oliveira on 16/02/24.
//

import Foundation

struct Mission: Codable, Identifiable {
    
    //our CrewRole struct was made specifically to hold data about missions, and as a result we can actually put the CrewRole struct inside the Mission struct like this:
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    // putting a Struct inside a Struct is called: nested struct, and is simply one struct placed inside of another. This won’t affect our code in this project, but elsewhere it’s useful to help keep your code organized: rather than saying CrewRole you’d write Mission.CrewRole. If you can imagine a project with several hundred custom types, adding this extra context can really help!
    
    let id: Int
    // this constant is optional because as you can see, this information on JSON maybe or not exist on all Missions. So codable will automatically skip this information if the value is missing from our input JSON.
    let launchDate: Date?
    //formatting launchDate to an specific format, using users timezone configuration and Strings
    var formattedLauchDate: String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
    //With that change our dates will be rendered in a much more natural way, and, even better, will be rendered in whatever way is region-appropriate for the user – what you see isn’t necessarily what I see
    let crew: [CrewRole]
    let description: String
    var displayName: String {
        "Apollo \(id)"
    }
    var image: String {
        "apollo\(id)"
    }
    
}
