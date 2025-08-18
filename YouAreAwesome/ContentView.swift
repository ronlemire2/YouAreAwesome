//
//  ContentView.swift
//  YouAreAwesome
//
//  Created by Ron Lemire on 8/10/25.
//

import SwiftUI
import AVFAudio

struct ContentView: View {
    @State private var message = ""
    @State private var imageName = ""
    @State private var lastMessageNumber = -1
    @State private var lastImageNumber = -1
    @State private var lastSoundNumber = -1
    @State private var audioPlayer: AVAudioPlayer!
    let numberOfImages = 9 // images labeled image0 - image9
    let numberOfSounds = 5 // images labeled image0 - image9
    
    var body: some View {
        VStack {
            Text(message)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundStyle(.red)
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.5)
                .frame(height: 100)
                .animation(.easeInOut(duration: 0.15), value: message)
            
            Image(imageName)
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .shadow(radius: 30)
                .animation(.default, value: imageName)
            
            Spacer()
            
            Button("Show Message") {
                let messages = ["You are Awesome!",
                                "When the Genius Bar Needs Help, They Call You!",
                                "You are Great!",
                                "You are Fantastic!",
                                "Fabulous? That's You!",
                                "You Make Me Smile!"
                               ]
                
                // Using while loop
                var messageNumber = Int.random(in: 0...messages.count - 1)
                while messageNumber == lastMessageNumber {
                    messageNumber = Int.random(in: 0...messages.count - 1)
                }
                message = messages[messageNumber]
                lastMessageNumber = messageNumber
                
                // Using repeat...while loop
                var imageNumber: Int
                repeat {
                    imageNumber = Int.random(in: 0...numberOfImages)
                } while imageNumber == lastImageNumber
                imageName = "image\(imageNumber)"
                lastImageNumber = imageNumber

                var soundNumber: Int
                repeat {
                    soundNumber = Int.random(in: 0...numberOfSounds)
                } while soundNumber == lastSoundNumber
                //TODO: Remove 'if' code when 'toggle sound' is implemented
                if soundNumber == 5 { // sound 5 is too long
                    soundNumber = 0
                }
                let soundName = "sound\(soundNumber)"
                lastSoundNumber = soundNumber
                
                guard let soundFile = NSDataAsset(name: soundName) else {
                    print("😡 Could not read file named \(soundName)")
                    return
                }
                do {
                    audioPlayer = try AVAudioPlayer(data: soundFile.data)
                    audioPlayer.play()
                } catch {
                    print("😡 ERROR: \(error.localizedDescription) creating audioPlayer.")
                }
                
            }
            .buttonStyle(.borderedProminent)
            .font(.title2)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
