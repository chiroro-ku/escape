//
//  GaugeViewProtocol.swift
//  escape
//
//  Created by 小林千浩 on 2024/06/09.
//

import Foundation

protocol GaugeViewProtocol {
    var label: String { get }
    var value: Int { get }
    var maxValue: Int { get }
}
