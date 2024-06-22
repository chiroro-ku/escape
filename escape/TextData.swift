//
//  TextData.swift
//  escape
//
//  Created by 小林千浩 on 2024/04/21.
//

import Foundation

class TextData{
    
    var delegate: TextDataProtocol?
    
    public func get(event: EventType) -> [GameText]{
        var text: [GameText] = []
        switch event {
        case .titleScene:
            text = self.text("▶︎逃げる▶︎攻撃する,をダウンロードしていただき…,ありがとうございます！")
            
        case .battleScene:
            text = self.text("ここをタップしてね！,ここをタップしてね！,テキスト送りができるよ！…,さあ、冒険の初まりです！…,モンスターを倒して強くなろう！…,でも強いモンスターからは逃げてね")
            text[0].setEvent(event: .battleScene)
            
        case .systemTransition:
            text = self.text(" , ")
            text[0].setEvent(event: .systemTransition)
            
        case .willBattle:
            text = self.text("テクテク…")
            text[0].setEvent(event: .walkPlayer)
            
        case .didBattle:
            text = self.text("テクテク…")
            text[0].setEvent(event: .walkPlayer)
            
        case .attackPlayer:
            text = self.text("\(self.pn())は攻撃した！…")
            text[0].setEvent(event: .attackPlayer)
            
        case .escapePlayer:
            text = self.text("\(self.pn())は逃げ出した…")
            text[0].setEvent(event: .escapePlayer)
            
        case .fleePlayer:
            text = self.text("やばい！,\(self.pn())は急いで逃げ出した！…")
            text[1].setEvent(event: .escapePlayer)
            
        case .levelUpPlayer:
            text = self.text("\(self.pn())はレベルが上がった！…")
            text[0].setEvent(event: .levelUpPlayer)
            
        case .deathPlayer:
            text = self.text("バタッ！,あなたの冒険は終わってしまった")
            text[0].setEvent(event: .deathPlayer)
            
        case .respawnMonster:
            text = self.text("\(self.mn())が現れた！…\(self.mt()),どうする？")
            text[0].setEvent(event: .respawnMonster)
            text[1].setEvent(event: .systemSelect)
            
        case .deathMonster:
            text = self.text("\(self.mn())を倒した！…")
            text[0].setEvent(event: .deathMonster)
            
        case .attackMonster:
            text = self.text("\(self.mn())は反撃してきた！…")
            text[0].setEvent(event: .attackMonster)
            
        case .eventMonster:
            break
            
        }
        return text
    }
    
    public func text(_ text: String) -> [GameText]{
        let textList = text.components(separatedBy: ",")
        var gameTextList: [GameText] = []
        for text in textList{
            let gameText = GameText(text, event: text.contains("…") ? .auto : nil)
            gameTextList.append(gameText)
        }
        return gameTextList
    }
    
    private func pn() -> String{
        return self.delegate?.player.name ?? Player().name
    }
    
    private func mn() -> String{
        return self.delegate?.monster?.name ?? Monster().name
    }
    
    private func mt() -> String{
        
        guard var text = self.delegate?.monster?.text else{
            return ""
        }
        
        if text == "_"{
            return ""
        }
        
        var textDatas = text.components(separatedBy: "-")
        for i in 0 ..< textDatas.count {
            if textDatas[i] == "Name"{
                textDatas[i] = self.mn()
            }
        }
        text = textDatas.joined()
        
        return ",\(text)"
    }
}
