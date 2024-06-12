//
//  Monster.swift
//  escape
//
//  Created by 小林千浩 on 2024/04/20.
//

import Foundation
import RealmSwift

class Monster: Object{
    
    @Persisted(primaryKey: true) var id: Int
    @Persisted var rank: Int
    @Persisted var name: String
    @Persisted var ration: Int
    @Persisted var damege: Int
    @Persisted var imageName: String
    @Persisted var text: String
    @Persisted var event: String
    @Persisted var eventValue: String
    @Persisted var type: String
    @Persisted var next: String
    @Persisted var level: Int
    
    private(set) var death: Bool = false
    
    func takeAttack(player: Player, _ bool: Bool = false){
        
        if bool {
            self.death = true
            return
        }
        
        let ration = self.ration - player.lv
        let random = Int.random(in: 1...100)
        self.death = random > ration
    }
    
}
