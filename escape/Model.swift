//
//  Model.swift
//  escape
//
//  Created by 小林千浩 on 2024/04/20.
//

import Foundation

class Model{
    
    private(set) var event: Event
    weak var view: ViewProtocol?
    
    init(){
        self.event = Event()
    }
    
    init(model: Model){
        self.event = model.event
        self.view = model.view
    }
    
    func load(value: Int){
        
    }
}
