//
//  TitleModel.swift
//  escape
//
//  Created by 小林千浩 on 2024/04/20.
//

import Foundation
import RealmSwift

class TitleModel: Model{
    override init() {
        super.init()
        
        let realm = try! Realm()
        var profiles = realm.objects(Profile.self)
        if profiles.isEmpty{
            let profile = Profile()
            profile.tutorial = true
            profile.waitingTime = 0.9
            try! realm.write{
                realm.add(profile)
            }
            print("debug - TitleModel.init()")
        }
        profiles = realm.objects(Profile.self)
        if let profile = profiles.first {
            self.load(profile: profile)
        }
        
        self.event.load(event: .titleScene)
    }
    
    override func load(value: Int){
        self.event.load()
        _ = self.view?.load()
    }
    
    public func load(profile: Profile){
        self.event.setProfile(profile: profile)
    }
}
