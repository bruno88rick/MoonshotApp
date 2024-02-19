//
//  Bundle-Decodable.swift
//  MoonshotApp
//
//  Created by Bruno Oliveira on 16/02/24.
//

import Foundation

//Next we want to convert astronauts.json into a dictionary of Astronaut instances, which means we need to use Bundle to find the path to the file, load that into an instance of Data, and pass it through a JSONDecoder. We’re going to write an extension on Bundle to do it all in one centralized place.

extension Bundle {
    func decode<T: Codable>(_ file: String) -> T {
        //searching the file in Bundle
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in Bundle.")
        }
        //loading file contents to data property of type Data
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from Bundle.")
        }
        
        //decoding the content of the file (that are on the data property) from JSON format and placing them on a array of type Astronaut (struct Astronaut)
        let decoder = JSONDecoder()
        
        //using dateDecodingStrategy to format dates:
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        //That tells the decoder to parse dates in the exact format we expect
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from Bundle.")
        }
        
        return loaded
    }
    
    //Be very careful: There is a big difference between T and [T]. Remember, T is a placeholder for whatever type we ask for, so if we say “decode our dictionary of astronauts,” then T becomes [String: Astronaut]. If we attempt to return [T] from decode() then we would actually be returning [[String: Astronaut]] – an array of dictionaries of astronauts!
    
    //If you try compiling this code, you’ll see an error in Xcode: “Instance method 'decode(_:from:)' requires that 'T' conform to 'Decodable’”. What it means is that T could be anything: it could be a dictionary of astronauts, or it could be a dictionary of something else entirely. The problem is that Swift can’t be sure the type we’re working with conforms to the Codable protocol, so rather than take a risk it’s refusing to build our code. Fortunately we can fix this with a constraint: we can tell Swift that T can be whatever we want, as long as that thing conforms to Codable. That way Swift knows it’s safe to use, and will make sure we don’t try to use the method with a type that doesn’t conform to Codable. Try deleting the conformes to Codable on func decode<T: Codable>() to see the error.
    
}


//code without treating generic type: Treating only the type [String: Astronaut]. With we refuse to use gennerics<T> we need to do another func to treat [Mission] data from missions.json.

/*
extension Bundle {
    func decode (_ file: String) -> [String: Astronaut] {
        //searching the file in Bundle
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in Bundle.")
        }
        //loading file contents to data property of type Data
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from Bundle.")
        }
        
        //decoding the content of the file (that are on the data property) from JSON format and placing them on a array of type Astronaut (struct Astronaut)
        let decoder = JSONDecoder()
        
        guard let loaded = try? decoder.decode([String: Astronaut].self, from: data) else {
            fatalError("Failed to decode \(file) from Bundle.")
        }
        
        return loaded
    }
}
*/

