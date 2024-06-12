//
//  TitleModel.swift
//  escape
//
//  Created by 小林千浩 on 2024/04/20.
//

import Foundation

class TitleModel: Model{
    override init() {
        super.init()
        self.event.load(event: .titleScene)
    }
    
    override func load(value: Int){
        self.event.load()
        _ = self.view?.load()
    }
}
