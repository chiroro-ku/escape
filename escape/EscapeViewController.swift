//
//  EscapeViewController.swift
//  escape
//
//  Created by 小林千浩 on 2024/04/20.
//

import UIKit

class EscapeViewController: UIViewController, DisplayViewProtocol, ButtonProtocol, ViewProtocol, HeaderViewProtocol {
    
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var displayView: DisplayView!
    @IBOutlet weak var coverView: UIView!
    
    var playerName: String{
        self.model.event.player.name
    }
    
    var playerLv: Int{
        self.model.event.player.lv
    }
    
    var playerHp: Int{
        self.model.event.player.hp
    }
    
    var playerMaxHp: Int{
        self.model.event.player.maxHP
    }
    
    var enemyName: String?{
        self.model.event.monster?.name
    }
    
    var text: String?{
        self.model.event.text.text
    }
    
    var backImageName: String?{
        self.model.event.backImageName
    }
    
    var imageName: String?{
        self.model.event.monster?.imageName
    }
    
    var model=Model()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.coverView.alpha = 1.0
        UIView.animate(withDuration: 1.0, animations: {
            self.coverView.alpha = 0.0
        })
    }
    
    public func loadedAnimate() {
        self.model.load(value: 0)
    }
    
    public func tappedTextButton(_ textButton: TextButton) {
        self.model.load(value: 0)
    }
    
    public func tappedButton(_ button: Button) {
        guard let value = button.value else {
            return
        }
        self.model.load(value: value)
    }
    
    public func loadText(){
        
    }
    
    public func load() -> EventType.Animate? {
        
        self.headerView.load()
        
        let animateEvent = self.model.event.text.event
        self.displayView.load(event: animateEvent)
        return animateEvent
    }
}
