//
//  Player.swift
//  escape
//
//  Created by 小林千浩 on 2024/04/20.
//

import Foundation

class Player{
    
    private let limitHp = 2000
    
    private(set) var name = "冒険者"
    private(set) var lv = 1{
        didSet{
            if self.lv > 300{
                self.lv = 300
            }
        }
    }
    private(set) var hp = 100 {
        didSet{
            if self.hp < 0{
                self.hp = 0
            }
            if self.hp > self.maxHP {
                self.hp = self.maxHP
            }
        }
    }
    private(set) var maxHP = 100{
        didSet{
            if maxHP < 10{
                self.maxHP = 10
            }
            if self.maxHP < self.hp{
                self.hp = self.maxHP
            }
            if self.maxHP > self.limitHp{
                self.maxHP = self.limitHp
            }
        }
    }
    
    public var death: Bool{
        get{
            self.hp <= 0
        }
    }
    
    init(name: String = "冒険者", lv: Int = 1, hp: Int = 100, maxHP: Int = 100) {
        self.name = name
        self.lv = lv
        self.maxHP = maxHP
        self.hp = hp
    }
    
    public func takeAttack(monster: Monster){
        self.hp -= monster.damege
    }
    
    public func levelUp(){
        self.lv += 1
        self.maxHP += 10
        self.hp += 30
    }
    
    public func levelUp(value: Int){
        for _ in 0..<value{
            self.levelUp()
        }
    }
    
    public func escape(){
        self.hp -= 11
    }
    
    public func setMaxHp(value: Int){
        self.maxHP = value
    }
    
    public func setHp(value: Int){
        self.hp = value
    }
}
