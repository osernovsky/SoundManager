//
//  SoundManagerApp.swift
//  SoundManager
//
//  Created by Sergey Dubrovin on 11.01.2025.
//

import SwiftUI

@main
struct SoundManagerApp: App {
    
    // Инициализация наблюдателей SoundManager
    init() {
        SoundManager.shared.setupNotificationObservers()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
