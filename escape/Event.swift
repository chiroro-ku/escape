//
//  Event.swift
//  escape
//
//  Created by 小林千浩 on 2024/04/20.
//

import Foundation
import RealmSwift

class Event: TextDataProtocol{
    
    private let monsterData = MonsterData()
    private let textData = TextData()
    
    private(set) var eventList: [EventType] = []
    private var monsterList: [Monster] = []
    private var textList: [GameText] = []
    
    private(set) var player = Player()
    private(set) var monster: Monster?
    
    private(set) var backImageName: String? = nil
    private(set) var text = GameText("")
    
    init(){
        self.textData.delegate = self
    }
    
    public func load(){
        if self.textList.isEmpty{
            if self.eventList.isEmpty{
                return
            }
            let event = self.eventList.removeFirst()
            self.load(event: event)
        }
        self.text = self.textList.removeFirst()
    }
    
    public func load(event: EventType){
        switch (event){
        case .titleScene:
            var maxLv = UserDefaults.standard.integer(forKey: "maxLv")
            if maxLv == 0 {
                maxLv = 1
            }
            self.player = Player(name: "最高記録", lv: maxLv)
            self.monster = self.monsterData.get(name: "スライム").first
            self.textList = self.textData.get(event: event)
            
        case .battleScene:
            self.player = Player()
            self.monster = nil
            self.textList = self.textData.get(event: event)
            self.monsterList = self.monsterData.get(level: self.player.lv)
            self.eventList.append(.willBattle)
            
        case .systemTransition:
            self.textList = self.textData.get(event: event)
            let maxLv = self.player.lv
            UserDefaults.standard.set(maxLv, forKey: "maxLv")
            
        case .willBattle:
            self.monster = self.monsterList.randomElement()
            self.textList = self.textData.get(event: event)
            
        case .didBattle:
            self.textList = self.textData.get(event: event)
            self.monster = nil
            self.eventList.append(.willBattle)
            
        case .attackPlayer:
            self.textList = self.textData.get(event: event)
            self.monster?.takeAttack(player: self.player)
            if monster?.death ?? false {
                self.eventList.append(.deathMonster)
            }else{
                self.eventList.append(.attackMonster)
            }
            
        case .escapePlayer:
            self.textList = self.textData.get(event: event)
            self.player.escape()
            if self.player.death{
                self.eventList.append(.deathPlayer)
            }else{
                self.eventList.append(.didBattle)
            }
            
        case .fleePlayer:
            self.textList = self.textData.get(event: event)
            self.eventList.append(.didBattle)
            
        case .levelUpPlayer:
            self.textList = self.textData.get(event: event)
            self.player.levelUp()
            self.eventList.append(.didBattle)
            
        case .deathPlayer:
            self.textList = self.textData.get(event: event)
            self.eventList.append(.systemTransition)
            
        case .deathMonster:
            self.textList = self.textData.get(event: event)
            guard let monster = self.monster else { return }
            let nextMonsterName = monster.next
            let appendMonsters = self.monsterData.get(name: nextMonsterName)
            if !appendMonsters.isEmpty{
//                print(appendMonsters[0].name)
                self.monsterList.append(appendMonsters[0])
            }
            self.eventList.append(.levelUpPlayer)
            
        case .attackMonster:
            self.textList = self.textData.get(event: event)
            guard let monster = self.monster else {
                print("error - Event.load()")
                return
            }
            self.player.takeAttack(monster: monster)
            if self.player.death {
                self.eventList.append(.deathPlayer)
            }else{
                self.eventList.append(.fleePlayer)
            }
            
        }
    }
}
