//
//  GameText.swift
//  escape
//
//  Created by 小林千浩 on 2024/04/21.
//

import Foundation

class GameText: NSObject{
    private(set) var text: String
    private(set) var event: EventType.Animate?
    
    override var description: String{
        String("GameText(text: \(self.text), event: \(self.event))")
    }
    
    init(_ text: String, event: EventType.Animate? = nil) {
        self.text = text
        self.event = event
    }
    
    public func setEvent(event: EventType.Animate?){
        self.event = event
    }
}
