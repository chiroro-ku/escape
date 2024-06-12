//
//  DisplayViewProtocol.swift
//  escape
//
//  Created by 小林千浩 on 2024/05/16.
//

import Foundation

protocol DisplayViewProtocol {
    var backImageName: String? { get }
    var imageName: String? { get }
    var text: String? { get }

    func tappedTextButton(_ textButton: TextButton)
    func loadedAnimate()
}
