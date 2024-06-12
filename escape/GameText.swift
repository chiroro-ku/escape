//
//  GameText.swift
//  escape
//
//  Created by 小林千浩 on 2024/04/21.
//

import Foundation

class GameText{
    private(set) var text: String
    private(set) var event: EventType.Animate?
    
    init(_ text: String, event: EventType.Animate? = nil) {
        self.text = text
        self.event = event
    }
    
    public func setEvent(event: EventType.Animate?){
        self.event = event
    }
}
