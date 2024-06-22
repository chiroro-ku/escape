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
            self.verificationLoad(event: event)
        }
        self.text = self.textList.removeFirst()
    }
    
    public func verificationLoad(event: EventType){
        if !self.loadEventMonster(event: event){
            self.load(event: event)
        }
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
//            self.player = Player(hp:1000, maxHP: 1000)
            self.player = Player()
            self.monster = nil
            self.textList = self.textData.get(event: event)
            self.monsterList = self.monsterData.get(level: self.player.lv)
//            self.monsterList = self.monsterData.get(event: "毒")
            self.eventList.append(.willBattle)
            
        case .systemTransition:
            self.textList = self.textData.get(event: event)
            let maxLv = self.player.lv
            UserDefaults.standard.set(maxLv, forKey: "maxLv")
            
        case .willBattle:
            self.monster = self.monsterList.randomElement()
            self.textList = self.textData.get(event: event)
            self.eventList.append(.respawnMonster)
            
        case .didBattle:
            self.textList = self.textData.get(event: event)
            self.monster = nil
            self.eventList.append(.willBattle)
            
        case .attackPlayer:
            self.textList = self.textData.get(event: event)
            self.monster?.takeAttack(player: self.player, true)
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
            
        case .respawnMonster:
            self.textList = self.textData.get(event: event)
            
        case .deathMonster:
            self.textList = self.textData.get(event: event)
            self.eventAppendMonster()
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
            
        case .eventMonster:
            break
            
        }
    }
    
    public func loadEventMonster(event: EventType) -> Bool{
        
        guard let monster = self.monster else {
            return false
        }
        
        if monster.event == "_" {
            return false
        }
        
        var flag = false
        
        switch monster.event {
        case "イタズラ":
            if event == .attackMonster{
                let value = monster.damege
                self.player.setMaxHp(value: self.player.maxHP - value)
                
                self.textList = self.textData.text("\(monster.name)は指を鳴らした！…,最大HPが\(value)減少した！")
                self.textList[0].setEvent(event: .magicMonster)
                
                self.eventList.append(.fleePlayer)
                
                flag = true
            }
            
        case "ケルベロス":
            if event == .attackMonster{
                self.textList = self.textData.text("\(monster.name)は反撃してきた！")
                self.monster?.eventStep = 0
                self.eventList.append(.eventMonster)
                flag = true
            }else if event == .eventMonster{
                if monster.eventStep == 0 || monster.eventStep == 1{
                    self.textList = self.textData.text("\(monster.name)の連続攻撃！…")
                    self.textList[0].setEvent(event: .attackMonster)
                    self.player.takeAttack(monster: monster)
                    self.monster?.eventStep += 1
                    
                    if self.player.death {
                        self.eventList.append(.deathPlayer)
                    }else{
                        self.eventList.append(.eventMonster)
                    }
                    flag = true
                }else if monster.eventStep == 2{
                    self.textList = self.textData.text("\(monster.name)の最後の攻撃！")
                    self.textList[0].setEvent(event: .attackMonster)
                    self.player.takeAttack(monster: monster)
                    
                    if self.player.death {
                        self.eventList.append(.deathPlayer)
                    }else{
                        self.eventList.append(.fleePlayer)
                    }
                    flag = true
                }
            }
            
        case "ランダム":
            if event == .attackPlayer{
                self.monster?.loadEventRandom()
                self.load(event: .attackPlayer)
                flag = true
            }
            
        case "経験値UP":
            if event == .levelUpPlayer{
                let value = monster.eventValue
                self.player.levelUp(value: value)
                self.textList += self.textData.text("いつもよりレベルが上がった！…")
                self.textList[0].setEvent(event: .levelUpPlayer)
                
                self.eventList.append(.didBattle)
                flag = true
            }
            
        case "激怒":
            if event == .respawnMonster{
                self.textList = self.textData.text("\(monster.name)が現れた！…,\(monster.name)は怒っている！…")
                self.textList[0].setEvent(event: .respawnMonster)
                
                self.eventList.append(.eventMonster)
                flag = true
            }else if event == .eventMonster{
                self.player.takeAttack(monster: monster)
                self.textList = self.textData.text("痛いっ！…,出会い頭に殴られた！")
                self.textList[0].setEvent(event: .attackMonster)
                
                if self.player.death{
                    self.eventList.append(.deathPlayer)
                }else{
                    self.textList.append(GameText("どうする？", event: .systemSelect))
                }
                flag = true
            }
            
        case "俊敏":
            if event == .escapePlayer {
                self.textList = self.textData.get(event: event)
                self.player.escape()
                if self.player.death{
                    self.eventList.append(.deathPlayer)
                }else{
                    self.textList += [GameText("しかし、回り込まれた！…", event: .chaseMonster)]
                    self.eventList.append(.eventMonster)
                }
                flag = true
            }else if event == .eventMonster {
                self.load(event: .attackMonster)
                flag = true
            }
            
        case "焼肉":
            if event == .levelUpPlayer{
                self.player.levelUp()
                self.textList = self.textData.get(event: event)
                self.eventList.append(.eventMonster)
                flag = true
            }else if event == .eventMonster{
                let value = monster.eventValue
                self.player.setHp(value: self.player.hp + value)
                self.textList = self.textData.text("\(monster.name)は美味だった！…,体力が回復した！")
                self.eventList.append(.didBattle)
                flag = true
            }
            
        case "食べる":
            if event == .attackPlayer{
                self.player.setHp(value: 0)
                self.textList = self.textData.text("近づいた瞬間飲み込まれた！…,\(self.player.name)は食べられた！")
                self.textList[0].setEvent(event: .eatMonster)
                self.eventList.append(.systemTransition)
                flag = true
            }
        
        case "魔法":
            if event == .attackPlayer{
                let value = monster.eventValue
                self.player.setHp(value: self.player.hp - value)
                
                self.textList = self.textData.text("\(monster.name)は魔法を唱えた！…,せこい！…")
                self.textList[0].setEvent(event: .magicMonster)
                
                if self.player.death {
                    self.eventList.append(.deathPlayer)
                }else{
                    self.eventList.append(.eventMonster)
                }
                flag = true
            }else if event == .eventMonster{
                self.load(event: .attackPlayer)
                flag = true
            }
        
        case "毒":
            if event == .deathMonster{
                self.textList = self.textData.text("\(monster.name)を倒した！…")
                self.textList[0].setEvent(event: .ruptureMonster)
                self.eventList.append(.eventMonster)
                flag = true
            } else if event == .eventMonster {
                self.player.setHp(value: self.player.hp - monster.eventValue)
                self.eventAppendMonster()
                self.textList = self.textData.text("爆発して毒を撒き散らした！…,\(self.player.name)は毒を浴びた！")
                self.eventList.append(.levelUpPlayer)
                flag = true
            }
            
        case "元気":
            break
            
        case "人間":
            break
            
        default:
            print("error - Event.loadEventMonster(event) - monster.event:\(monster.event), event:\(event)")
            break
        }
        
        return flag
    }
    
    public func eventAppendMonster(){
        guard let monster = self.monster else { return }
        let nextMonsterName = monster.next
        let appendMonsters = self.monsterData.get(name: nextMonsterName)
        if !appendMonsters.isEmpty{
            self.monsterList.append(appendMonsters[0])
            let list = Set(self.monsterList)
            let value = list.count
            if value == 65 {
                let nextAppendMonsters = self.monsterData.get(level: 2)
                for nextAppendMonster in nextAppendMonsters {
                    print("load - append \(nextAppendMonster.name)")
                }
                self.monsterList += nextAppendMonsters
            }else if value == 85 {
                let nextAppendMonsters = self.monsterData.get(level: 3)
                for nextAppendMonster in nextAppendMonsters {
                    print("load - append \(nextAppendMonster.name)")
                }
                self.monsterList += nextAppendMonsters
            }else if value == 105 {
                let nextAppendMonsters = self.monsterData.get(level: 4)
                for nextAppendMonster in nextAppendMonsters {
                    print("load - append \(nextAppendMonster.name)")
                }
                self.monsterList += nextAppendMonsters
            }else if value >= 125 {
                let nextAppendMonsters = self.monsterData.get(level: 5)
                for nextAppendMonster in nextAppendMonsters {
                    print("load - append \(nextAppendMonster.name)")
                }
                self.monsterList += nextAppendMonsters
            }
        }
    }
}
