//
//  NavigationBarView.swift
//  TrialsOfTheEveryday
//
//  Created by Tobias Pummer on 09.09.24.
//

import SwiftUI
import SFSafeSymbols

struct RootView: View {
    @State var ViewState: Int = 1
    @State var showMissions: Bool = false
    @StateObject var viewModel: DataContainerViewModel
    @ObservedObject var manager: HealthManager
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    TopBarView(manager: manager)
                    
                    if ViewState == 1 {
                        HStack {
                            Spacer()
                            
                            ShowMissionsView(showMissions: $showMissions)
                                .padding(.trailing, 10)
                        }
                    }
                    
                    if ViewState == 0 {
                        PlayerScreenView(helmets: viewModel.helmets, chestplates: viewModel.chestplates, boots: viewModel.boots, weapons: viewModel.weapons, rings: viewModel.rings, amuletts: viewModel.amuletts, skills: viewModel.skills)
                            .onAppear {
                                manager.fetchTodaySteps()
                            }
                            
                    }
                    else if ViewState == 1 {
                        HomeScreenView(ViewState: $ViewState)
                            .onAppear {
                                manager.fetchTodaySteps()
                            }
                    }
                    else if ViewState == 2 {
                        ShopView()
                            .onAppear {
                                manager.fetchTodaySteps()
                            }
                    }
                    else if ViewState == 3 {
                        DungeonOverviewView(ViewState: $ViewState, enemies: viewModel.enemies, viewModel: viewModel)
                            .onAppear {
                                manager.fetchTodaySteps()
                            }
                    }
                    
                    NavigationBarView(ViewState: $ViewState) // NavBar unten
                }
                .background(Image("HomeScreenDungeon"))
                .disabled(showMissions)
                
                if showMissions {
                  MissionsView(manager: manager, isPresented: $showMissions)
                }
            }
            .onAppear {
                viewModel.filterItems()
            }
        }
    }
}
/*
#Preview {
  RootView(viewModel: DataContainerViewModel(), manager: manager)
}
 */

struct TopBarView: View {
    @AppStorage("stamina") private var stamina: Int = 0
    @AppStorage("gems") private var gems: Int = 0
    @AppStorage("coins") private var coins: Int = 0
    var manager: HealthManager
    
    var body: some View {
        ZStack {
            WoodBackgroundView()
            
            HStack (spacing: 80){
                Group {
                    HStack {
                        Image(systemSymbol: .boltCircle)
                            .foregroundStyle(Color.blue)
                            .background(Color.black.clipShape(Circle()))
                        Text("\(stamina)")
                            .font(Font.custom("Enchanted Land", size: 40))
                    }
                        
                    HStack {
                        Image(systemSymbol: .diamondCircle)
                            .foregroundStyle(Color.purple)
                            .background(Color.black.clipShape(Circle()))
                        Text("\(gems)")
                            .font(Font.custom("Enchanted Land", size: 40))
                    }
                    
                    HStack {
                        Image(systemSymbol: .centsignCircle)
                            .foregroundStyle(Color.yellow)
                            .background(Color.black.clipShape(Circle()))
                        Text("\(coins)")
                            .font(Font.custom("Enchanted Land", size: 40))
                    }
                }
                .font(.title)
                .foregroundStyle(Color.white)
            }
            .padding(.bottom, 5)
        }
        .onAppear {
            manager.fetchTodaySteps()
        }
    }
}

struct NavigationBarView: View {
    @Binding var ViewState: Int
    
    var body: some View {
        ZStack {
            WoodBackgroundView()
            
            HStack (alignment: .center, spacing: 80){
                Image(systemSymbol: .personCircleFill)
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(Color.black)
                    .background(Circle().foregroundStyle(ViewState == 0 ? Color.green : Color.white))
                    .onTapGesture {
                        withAnimation {
                            ViewState = 0
                        }
                    }
                
                Image(systemSymbol: .houseCircleFill)
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(Color.black)
                    .background(Circle().foregroundStyle(ViewState == 1 ? Color.green : Color.white))
                    .onTapGesture {
                        withAnimation {
                            ViewState = 1
                        }
                    }
                
                Image(systemSymbol: .cartCircleFill)
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(Color.black)
                    .background(Circle().foregroundStyle(ViewState == 2 ? Color.green : Color.white))
                    .onTapGesture {
                        withAnimation {
                            ViewState = 2
                        }
                    }
            }
            .frame(height: 50)
            .padding(.bottom, 5)
        }
    }
}

struct WoodBackgroundView: View {
    var body: some View {
        Grid(horizontalSpacing: 0, verticalSpacing: 0) {
            GridRow {
                Image("01_Bridge_All")
                    .resizable()
                Image("01_Bridge_All")
                    .resizable()
                Image("01_Bridge_All")
                    .resizable()
                Image("01_Bridge_All")
                    .resizable()
                Image("01_Bridge_All")
                    .resizable()
            }
        }
        .frame(height: 80)
    }
}

struct ShowMissionsView: View {
    @Binding var showMissions: Bool
    
    var body: some View {
        VStack (alignment: .trailing){
            Image("02")
                .overlay {
                    Image(systemSymbol: .exclamationmark)
                        .resizable()
                        .scaledToFit()
                        .padding(.top, 5)
                        .padding(.bottom, 5)
                        .foregroundStyle(Color.white)
                }
                .onTapGesture {
                    withAnimation {
                        showMissions.toggle()
                    }
                }
        }
    }
}
