//
//  ShopView.swift
//  TrialsOfTheEveryday
//
//  Created by Sebastian Maier on 19.09.24.
//

import SwiftUI
import SFSafeSymbols

struct ShopView: View {
    var body: some View {
        Image(systemSymbol: .cartCircle)
            .foregroundStyle(Color.white)
            .scaledToFill()
    }
}

#Preview {
    ShopView()
}
