//
//  EventType.swift
//  escape
//
//  Created by 小林千浩 on 2024/04/20.
//

import Foundation

enum EventType: String {
    
    case titleScene = "titleScene"
    case battleScene = "battleScene"
    
    case systemTransition = "systemTransition"
    
    case willBattle = "willBattle"
    case didBattle = "didBattle"
    
    case attackPlayer = "attackPlayer"
    case escapePlayer = "escapePlayer"
    case fleePlayer = "fleePlayer"
    case levelUpPlayer = "levelUpPlayer"
    case deathPlayer = "deathPlayer"
    
    case deathMonster = "deathMonster"
    case attackMonster = "attackMonster"
    case respawnMonster = "respawnMonster"
    case eventMonster = "eventMonster"
    
    enum Monster{
        case event(Int)
    }
    
    enum Animate: String {
        case auto = "Animate.auto"
        
        case battleScene = "Animate.battleScene"
        
        case systemTransition = "Animate.systemTransition"
        case systemSelect = "Animate.systemSelect"
        case systemStress = "Animate.systemStress"
        
        case respawnMonster = "Animate.respawnMonster"
        case deathMonster = "Animate.deathMonster"
        case attackMonster = "Animate.attackMonster"
        case eventMonster = "Animate.eventMonster"
        case magicMonster = "Animate.magicMonster"
        case chaseMonster = "Animate.chaseMonster"
        case eatMonster = "Animate.eatMonster"
        case ruptureMonster = "Animate.ruptureMonster"
        
        case walkPlayer = "Animate.walkPlayer"
        case escapePlayer = "Animate.escapePlayer"
        case attackPlayer = "Animate.attackPlayer"
        case levelUpPlayer = "Animate.levelUpPlayer"
        case deathPlayer = "Animate.deathPlayer"
    }
}
