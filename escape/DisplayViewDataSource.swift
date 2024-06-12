//
//  DisplayViewDatasurce.swift
//  escape
//
//  Created by 小林千浩 on 2024/05/15.
//

import Foundation

protocol DisplayViewDataSource {
    var backImageName: String? { get }
    var imageName: String? { get }
    var text: String? {get}
    
    
}
