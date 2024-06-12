//
//  HeaderViewProtocol.swift
//  escape
//
//  Created by 小林千浩 on 2024/06/09.
//

import Foundation

protocol HeaderViewProtocol {
    var playerName: String { get }
    var playerLv: Int { get }
    var playerHp: Int { get }
    var playerMaxHp: Int { get }
    var enemyName: String? { get }
}
