//
//  MainModel.swift
//  escape
//
//  Created by 小林千浩 on 2024/04/20.
//

import UIKit

class MainModel: Model {
    override init(model: Model){
        super.init(model: model)
        self.event.load(event: .battleScene)
    }
    
    override func load(value: Int) {
        if value == 0{
            
        }else if value == 1 && self.event.eventList.isEmpty{
            self.event.verificationLoad(event: .attackPlayer)
        }else if value == 2 && self.event.eventList.isEmpty{
            self.event.verificationLoad(event: .escapePlayer)
        }else{
            return
        }
        self.event.load()
        _ = self.view?.load()
    }
}
