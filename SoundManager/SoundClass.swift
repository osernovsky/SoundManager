
import AVFoundation
import UIKit

class SoundManager: NSObject {
    
    static let shared = SoundManager() // Синглтон
    
    // Флаг активной паузы сворачивания приложения
    private var isPausedBySystem = false
    
    private var musicPlayer: AVAudioPlayer! // Плейер фоновой музыки
    private var soundPlayers: [AVAudioPlayer] = [] // Массив плейеров звуковых эффектов
    
    private override init() {
        super.init()
    }

    deinit {        
        // Отписка от уведомлений в деинициализаторе
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: Настройка подписки на уведомления
    func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleAppDidEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleAppDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    // MARK: Функция проигрывания фоновой музыки    
    func playMusic(named musicName: String, withExtension extensionName: String = "mp3", loop: Bool = true, volume: Float = 100) {
        
        if let musicURL = Bundle.main.url(forResource: musicName, withExtension: extensionName) {
            do {
                musicPlayer = try AVAudioPlayer(contentsOf: musicURL)
                musicPlayer.prepareToPlay()
                musicPlayer.volume = volume / 100
                musicPlayer.numberOfLoops = loop ? -1 : 0
                musicPlayer.play()
            } catch {
                print("Error loading music: \(error)")
            }
        } else {
            print("Error playing music")
        }     
    }
    
    // MARK: Функция проигрывания звуков    
    func playSound(named soundName: String, withExtension extensionName: String = "mp3", volume: Float = 100) {
        
        if let soundURL = Bundle.main.url(forResource: soundName, withExtension: extensionName) {
            do {
                let player = try AVAudioPlayer(contentsOf: soundURL)
                player.prepareToPlay()
                player.volume = volume / 100
                player.play()
                soundPlayers.append(player) // Добавляем плейер в массив
                player.delegate = self // Удаляем из массива по окончании воспроизведения
            } catch {
                print("Error loading music: \(error)")
            }
        } else {
            print("Error playing sound")
        }
    }
    
    // Остановка проигрывания музыки
    func stopMusic() {
        if musicPlayer != nil {
            musicPlayer?.stop()
            musicPlayer = nil
        }
    }
    
    // Остановка всех звуковых эффектов
    func stopAllSound() {
        for player in soundPlayers {
            player.stop()
        }
        soundPlayers.removeAll()
    }
    
    // Изменение громкости музыки
    func setMusicVolume(_ volume: Float) {
        if volume > 0.0 && volume <= 100 {
            musicPlayer?.volume = volume / 100
        }
    }
    
    // Изменение громкости всех звуковых эффектов
    func setSoundVolume(_ volume: Float) {
        if volume > 0.0 && volume <= 100 {
            if !soundPlayers.isEmpty {
                for player in soundPlayers {
                    player.volume = volume / 100
                }
            }
        }
    }
    
    // Пауза музыки (для наблюдателя)
    func pauseMusic() {
        if musicPlayer?.isPlaying == true {
            musicPlayer?.pause()
        }
    }

    // Возобновление музыки (для наблюдателя)
    func resumeMusic() {
        if let player = musicPlayer, !player.isPlaying {
            player.play()
        }
    }
    
    // Обработчик: приложение свернулось
    @objc private func handleAppDidEnterBackground() {
        if musicPlayer?.isPlaying == true {
            // Устанавливаем флаг, что музыка была приостановлена системой
            isPausedBySystem = true
            pauseMusic()
        }
    }

    // Обработчик: приложение снова активно
    @objc private func handleAppDidBecomeActive() {
        // Если пауза была установлена сворачиванием, возобновляем музыку
        if isPausedBySystem {
            resumeMusic()
            isPausedBySystem = false // Сбрасываем флаг
        }
    }
}

extension SoundManager: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        // Удаляем плеер из массива после завершения воспроизведения
        if let index = soundPlayers.firstIndex(of: player) {
            soundPlayers.remove(at: index)
        }
    }
}
