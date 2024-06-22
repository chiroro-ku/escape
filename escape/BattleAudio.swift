//
//  BattleAudio.swift
//  escape
//
//  Created by 小林千浩 on 2024/04/21.
//

import UIKit

class BattleAudio: Audio {
    
    public func escapePlayer(){
        self.play(fileName: "maou_se_battle19", extentionName: "mp3")
    }
    
    public func attackPlayer(){
        self.play(fileName: "maou_se_battle03", extentionName: "mp3")
    }
    
    public func levelUpPlayer(){
        self.play(fileName: "nc295968", extentionName: "mp3")
    }
    
    public func attackMonster(){
        self.play(fileName: "maou_se_battle16", extentionName: "mp3")
    }
    
    public func deathMonster(){
        self.play(fileName: "maou_se_8bit12", extentionName: "mp3")
    }
    
    public func magicMonster(){
        self.play(fileName: "maou_se_magical09", extentionName: "mp3")
    }
}
