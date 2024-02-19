//
//  Astronaut.swift
//  MoonshotApp
//
//  Created by Bruno Oliveira on 16/02/24.
//

import Foundation

//As you can see, I’ve made that conform to Codable so we can create instances of this struct straight from JSON, but also Identifiable so we can use arrays of astronauts inside ForEach and more – that id field will do just fine.

struct Astronaut: Codable, Identifiable {
    let id: String
    let name: String
    let description: String
}
