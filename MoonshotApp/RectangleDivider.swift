//
//  RectangleDivider.swift
//  MoonshotApp
//
//  Created by Bruno Oliveira on 28/02/24.
//

import SwiftUI

struct RectangleDivider: View {
    var body: some View {
        Rectangle()
            .frame(height:2)
            .foregroundStyle(.lightBackground)
            .padding(.vertical, 2)
    }
}

#Preview {
    RectangleDivider()
}
