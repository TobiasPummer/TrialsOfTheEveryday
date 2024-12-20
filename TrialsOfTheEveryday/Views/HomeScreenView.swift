//
//  HomeScreenView.swift
//  TrialsOfTheEveryday
//
//  Created by Tobias Pummer on 09.09.24.
//

import SwiftUI
import HealthKit

struct HomeScreenView: View {
    @Binding var ViewState: Int
    
    var body: some View {
        VStack {
            LevelView(level: 4, ViewState: $ViewState)
                
            LevelView(level: 3, ViewState: $ViewState)
            
            LevelView(level: 2, ViewState: $ViewState)
            
            LevelView(level: 1, ViewState: $ViewState)
            
            PixelAnimationView(imageNames: CharacterImages.warrior.imageNames, fps: 10)
                .scaledToFit()
                .frame(width: 200)
        }
    }
}

#Preview {
    HomeScreenView(ViewState: .constant(1))
}

struct LevelView: View {
    var level: Int
    var mineWidth: CGFloat = 120
    @Binding var ViewState: Int
    @AppStorage("levelState") private var levelState: Int = 1
    var body: some View {
        MineView()
            .frame(width: mineWidth)
            .overlay {
                if levelState < level {
                    Image("Regular_10")
                        .resizable()
                        .scaledToFill()
                }
            }
            .offset(x: level%2==0 ? 100:-100)
            .onTapGesture {
                ViewState = 3
            }
            .disabled(levelState != level)
    }
}
