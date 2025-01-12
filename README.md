# Менеджер звуков

Это менеджер звуков для iOS/MacOS, выполненный на Swift в виде отдельного класса (синглтона) с вложенными методами. Поддерживается раздельное проигрывание фоновой музыки с зацикливанием, а так же проигрывание отдельных звуковых эффектов с одновременным звучанием - вызов следующего эффекта не прервет уже звучащие. Реализована раздельная регулировка громкости, а так же полной остановки музыки и звуковых эффетов. В классе есть наблюдатель приложения, при его активации сворачивание поставит звучащую фоновую музыку на паузу, при возврате продолжит воспроизведение.

# Sound Manager

This is a sound manager for iOS/MacOS, written in Swift as a separate class (singleton) with nested methods. It supports separate playback of background music with looping, as well as playback of separate sound effects with simultaneous sounding - calling the next effect will not interrupt the already sounding ones. Separate volume control is implemented, as well as full stop of music and sound effects. There is an application watcher in the class, when activated, minimisation will pause the background music, and when you return it will continue playing.

![SoundManager](https://github.com/user-attachments/assets/92118265-1dcc-41a3-9217-5da87cdd2c6e)
