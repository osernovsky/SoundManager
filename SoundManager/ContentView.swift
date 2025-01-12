//
//  ContentView.swift
//  SoundManager
//
//  Created by Sergey Dubrovin on 11.01.2025.
//

import SwiftUI

struct ContentView: View {
    
    @State var sliderOneValue: Double = 50
    @State var sliderTwoValue: Double = 100
    
    var body: some View {
        
        Text("Sound manager")
            .bold()
            .font(.largeTitle)
            .padding(50)
        
        
        VStack {
            
            Text("Music Volume")
            
            Slider(value: $sliderOneValue, in: 0...100, step: 1)
                .onChange(of: sliderOneValue) { newValue in
                    SoundManager.shared.setMusicVolume(Float(newValue))
                }
                .padding()
            
            HStack {
                
                Button("Play Music") {
                    SoundManager.shared.playMusic(named: "foneMusic", volume: Float(sliderOneValue))
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(Color.white)
                .cornerRadius(10)
                .padding()
                
                Button("Stop Music") {
                    SoundManager.shared.stopMusic()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(Color.white)
                .cornerRadius(10)
                .padding()
            }
            
            Text("Sound Volume")
            
            Slider(value: $sliderTwoValue, in: 0...100, step: 1)
                .onChange(of: sliderTwoValue) { newValue in
                    SoundManager.shared.setSoundVolume(Float(newValue))
                }
                .padding()

            HStack {
                Button("Play Sound") {
                    SoundManager.shared.playSound(named: "endGame", volume: Float(sliderTwoValue))
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(Color.white)
                .cornerRadius(10)
                .padding()
                
                Button("Stop Sound") {
                    SoundManager.shared.stopAllSound()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(Color.white)
                .cornerRadius(10)
                .padding()
            }
            
        }
    }
}

#Preview {
    ContentView()
}
