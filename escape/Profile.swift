//
//  Profile.swift
//  escape
//
//  Created by 小林千浩 on 2024/07/14.
//

import Foundation
import RealmSwift

class Profile: Object{
    
    @Persisted(primaryKey: true) var id: Int
    @Persisted var tutorial: Bool
    @Persisted var waitingTime: Float
    
}
