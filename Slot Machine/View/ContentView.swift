//
//  ContentView.swift
//  Slot Machine
//
//  Created by user on 17.06.2022.
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTY
    let symbols = ["gfx-bell", "gfx-cherry", "gfx-coin", "gfx-grape", "gfx-seven", "gfx-strawberry"]
    
    @State private var highscore: Int = 0
    @State private var coins: Int = 100
    @State private var betAmount: Int = 10
    @State private var reels: Array = [0, 1, 2]
    @State private var showingInfoView: Bool = false
    @State private var isActivateBet10: Bool = true
    @State private var isActivateBet20: Bool = false
    @State private var showingModal: Bool = false
    
    // MARK: - FUNCTIONS
    
    // Spin The Reels
    func spinReels() {
        // reels[0] = Int.random(in: 0...symbols.count - 1)
        // reels[1] = Int.random(in: 0...symbols.count - 1)
        // reels[2] = Int.random(in: 0...symbols.count - 1)
        reels = reels.map({ _ in
            Int.random(in: 0...symbols.count - 1)
        })
    }
    
    // Check The Winning
    func checkWinning() {
        if reels[0] == reels[1] && reels[1] == reels[2] && reels[0] == reels[2] {
            // Player Wins
            playerWins()
            
            // New Highscore
            if coins > highscore {
                newHighscore()
            }
            
        }else {
            // Player Loses
            playerLoses()
            
        }
    }
    
    func playerWins() {
        coins += betAmount * 10
    }
    
    func newHighscore() {
        highscore = coins
    }
    
    func playerLoses() {
        coins -= betAmount
    }
    
    func acitvateBet20() {
        betAmount = 20
        isActivateBet20 = true
        isActivateBet10 = false
    }
    
    func activateBet10() {
        betAmount = 10
        isActivateBet20 = false
        isActivateBet10 = true
    }
    
    // Game Is Over
    func isGameOver()  {
        if coins <= 0 {
            // Show Modal Window
            showingModal = true
        }
    }
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            // MARK: - Background
            LinearGradient(gradient: Gradient(colors: [Color("ColorPink"), Color("ColorPurple")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            // MARK: - Interface
            VStack(alignment: .center, spacing: 5.0) {
                // MARK: - Header
                LogoView()
                
                Spacer()
                // MARK: - Score
                HStack {
                    HStack {
                        Text("Your \nCoins".uppercased())
                            .scoreLabelStyle()
                            .multilineTextAlignment(.trailing)
                        
                        Text("\(coins)")
                            .scoreNumberStyle()
                            .modifier(ScoreNumberModifier())
                    } // HStack
                    .modifier(ScoreContainerModifier())
                    
                    Spacer()
                    
                    HStack {
                        Text("\(highscore)")
                            .scoreNumberStyle()
                            .modifier(ScoreNumberModifier())
                        
                        Text("High \nScore".uppercased())
                            .scoreLabelStyle()
                            .multilineTextAlignment(.leading)
                    } // HStack
                    .modifier(ScoreContainerModifier())
                } // HStack
                
                // MARK: - Slot Machine
                VStack(alignment: .center, spacing: 0) {
                    // MARK: - REEl #1
                    ZStack {
                        ReelView()
                        Image(symbols[reels[0]])
                            .resizable()
                            .modifier(ImageModifier())
                    } // ZStack
                    
                    HStack(alignment: .center, spacing: 0) {
                        // MARK: - REEL #2
                        ZStack {
                            ReelView()
                            Image(symbols[reels[1]])
                                .resizable()
                                .modifier(ImageModifier())
                        } // ZStack
                        
                        Spacer()
                        
                        // MARK: - REEL #3
                        ZStack {
                            ReelView()
                            Image(symbols[reels[2]])
                                .resizable()
                                .modifier(ImageModifier())
                        } // ZStack
                    } // HStack
                    .frame(maxWidth: 500.0)
                        
                    // MARK: - Spin Button
                    Button(action: {
                        // Spin The Reels
                        self.spinReels()
                        
                        // Check Winning
                        self.checkWinning()
                        
                        // Game Is Over
                        self.isGameOver()
                        
                    }, label: {
                        Image("gfx-spin")
                            .renderingMode(.original)
                            .resizable()
                            .modifier(ImageModifier())
                    })
                    
                } // VStack
                .layoutPriority(2)
                
                // MARK: - Footer
                
                Spacer()
                
                HStack {
                    // MARK: - Bet 20
                    HStack(alignment: .center, spacing: 10.0) {
                        Button(action: {
                            self.acitvateBet20()
                        }, label: {
                            Text("20")
                                .fontWeight(.heavy)
                                .foregroundColor(isActivateBet20 ? Color("ColorYellow"): .white)
                                .modifier(BetNumberModifier())
                        })
                            .modifier(BetCapsuleModifier())
                        
                        Image("gfx-casino-chips")
                            .resizable()
                            .opacity(isActivateBet20 ? 1 : 0)
                            .modifier(CasinoChipsModifier())
                    } // HStack
                    
                    // MARK: - Bet 10
                    HStack(alignment: .center, spacing: 10.0) {
                        Image("gfx-casino-chips")
                            .resizable()
                            .opacity(isActivateBet10 ? 1 : 0)
                            .modifier(CasinoChipsModifier())
                        
                        Button(action: {
                            self.activateBet10()
                        }, label: {
                            Text("10")
                                .fontWeight(.heavy)
                                .foregroundColor(isActivateBet10 ? Color("ColorYellow") : .white)
                                .modifier(BetNumberModifier())
                        })
                            .modifier(BetCapsuleModifier())
                    } // HStack
                } // HStack
            }
            
            // MARK: - Buttons
            .overlay(
                // Reset
                Button(action: {
                    print("Reset the game")
                }, label: {
                    Image(systemName: "arrow.2.circlepath.circle")
                })
                    .modifier(ButtonModifier()),
                alignment: .topLeading
            )
            .overlay(
                // Info
                Button(action: {
                    self.showingInfoView = true
                }, label: {
                    Image(systemName: "info.circle")
                })
                    .modifier(ButtonModifier()),
                alignment: .topTrailing
            )
            
            .padding()
            .frame(maxWidth: 720.0)
            .blur(radius: $showingModal.wrappedValue ? 5.0 : 0, opaque: false)
            
            // MARK: - Popup
            if $showingModal.wrappedValue {
                ZStack {
                    Color("ColorTransparentBlack").edgesIgnoringSafeArea(.all)
                    
                    // Modal
                    VStack(spacing: 0) {
                        Text("GAME OVER")
                            .font(.system(.title, design: .rounded))
                            .fontWeight(.heavy)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(Color("ColorPink"))
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        VStack(alignment: .center, spacing: 16.0) {
                            Image("gfx-seven-reel")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 72.0)
                            
                            Text("Bad luck! You lost all of the coins. \nLet's play again!")
                                .font(.system(.body, design: .rounded))
                                .lineLimit(2)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.gray)
                                .layoutPriority(1)
                            
                            Button(action: {
                                self.showingModal = false
                                self.coins = 100
                            }, label: {
                                Text("New Game".uppercased())
                                    .font(.system(.body, design: .rounded))
                                    .fontWeight(.semibold)
                                    .accentColor(Color("ColorPink"))
                                    .padding(.horizontal, 12.0)
                                    .padding(.vertical, 8.0)
                                    .frame(minWidth: 128.0)
                                    .background(
                                        Capsule()
                                            .strokeBorder(lineWidth: 1.75)
                                            .foregroundColor(Color("ColorPink"))
                                    )
                            })
                        }
                        
                        Spacer()
                        
                    }.frame(minWidth: 280.0, idealWidth: 280.0, maxWidth: 320.0, minHeight: 260.0, idealHeight: 280.0, maxHeight: 320.0, alignment: .center)
                        .background(.white)
                        .cornerRadius(20.0)
                        .shadow(color: Color("ColorTransparentBlack"), radius: 6.0, x: 0, y: 8)
                    
                }
            }
            
        } // ZStack
        .sheet(isPresented: $showingInfoView) {
            InfoView()
        }
    }
}

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
