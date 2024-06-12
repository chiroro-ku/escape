//
//  Audio.swift
//  Bouken
//
//  Created by 小林千浩 on 2023/11/17.
//

import Foundation
import AVFoundation

class Audio{

    var audioPlayerInstance : AVAudioPlayer = AVAudioPlayer()
    
    public func play(fileName:String, extentionName:String){
        guard let soundFilePath = Bundle.main.path(forResource:fileName, ofType: extentionName) else {
                return
        }
        let sound = URL(fileURLWithPath: soundFilePath)
        do {
            audioPlayerInstance = try AVAudioPlayer(contentsOf: sound, fileTypeHint:nil)
        } catch let error {
            print(error)
        }
        do {
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(AVAudioSession.Category.ambient)
            try audioSession.setActive(true)
        } catch let error {
            print(error)
        }
            
        audioPlayerInstance.prepareToPlay()
        audioPlayerInstance.currentTime = 0
        audioPlayerInstance.play()
    }
    
    public func buttonTapped(){
        self.play(fileName: "maou_se_system23", extentionName: "mp3")
    }
    
    public func textButtonTapped(){
        self.play(fileName: "maou_se_system44", extentionName: "mp3")
    }
}
