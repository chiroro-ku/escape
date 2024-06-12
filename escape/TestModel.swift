//
//  TestModel.swift
//  escape
//
//  Created by 小林千浩 on 2024/04/20.
//

import Foundation
import RealmSwift

class TestModel: Model{
    
    override init() {
        super.init()
        
        let monster = Monster()
        monster.name = "スライム"
        monster.rank = 100
        monster.imageName = "pipo-enemy009"
        
        let realm = try! Realm()

        try! realm.write{
            realm.add(monster)
        }
        
        let monsters = realm.objects(Monster.self)
//        self.event.setMonster(monster: monsters[0])
    }
}
