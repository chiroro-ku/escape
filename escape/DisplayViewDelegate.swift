//
//  DisplayViewProtocol.swift
//  Bouken
//
//  Created by 小林千浩 on 2023/11/23.
//

import Foundation

protocol DisplayViewDelegate {
    
    var backImageName: String? { get }
    var imageName: String? { get }
    
    func textButtonTapped()
    func loadedAnimate()
    
}
