//
//  ReturnDataForViews.swift
//  MoonshotApp
//
//  Created by Bruno Oliveira on 28/02/24.
//

import Foundation

struct ReturnDataForViews {
    
    //all we’ve done is just moved code out of ContentView and into an extension (see Bundle-Decodable), but there’s nothing wrong with that – anything we can do to help our views stay small and focused is a good thing
    
    //“Generic parameter 'T' could not be inferred”, over in the astronauts property of ContentView. This line worked fine before, but there has been an important change now: before decode() would always return a dictionary of astronauts, but now it returns anything we want as long as it conforms to Codable. We know it will still return a dictionary of astronauts because the actual underlying data hasn’t changed, but Swift doesn’t know that. Our problem is that decode() can return any type that conforms to Codable, but Swift needs more information – it wants to know exactly what type it will be. Try deleting the type on the constant astronauts. "[String: Astronaut] ou from missions too to see the error. Deleting this works well if we're not decoding and returning generics<T> types. So, to use with geneics we need to use a type annotation so Swift knows exactly what astronauts will be
    
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
}
