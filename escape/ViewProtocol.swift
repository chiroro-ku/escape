//
//  ViewProtocol.swift
//  escape
//
//  Created by 小林千浩 on 2024/04/20.
//

import Foundation

protocol ViewProtocol: AnyObject {
    func load() -> EventType.Animate?
}
