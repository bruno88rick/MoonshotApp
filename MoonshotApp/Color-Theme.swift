//
//  Color-Theme.swift
//  MoonshotApp
//
//  Created by Bruno Oliveira on 19/02/24.
//

import SwiftUI

enum viewType {
    case grid
    case list
}

//we want to add functionality to ShapeStyle, but only for times when it’s being used as a color
extension ShapeStyle where Self == Color {
    static var darkBackground: Color {
        Color(red: 0.1, green: 0.1, blue: 0.2)
    }
    
    static var lightBackground: Color {
        Color(red: 0.2, green: 0.2, blue: 0.3)
    }
}

//That adds two new colors called darkBackground and lightBackground, each with precise values for red, green, and blue. But more importantly they place those inside a very specific extension that allows us to use those colors everywhere SwiftUI expects a ShapeStyle
