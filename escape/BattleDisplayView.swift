//
//  BattleDisplayView.swift
//  escape
//
//  Created by 小林千浩 on 2024/04/21.
//

import UIKit

class BattleDisplayView: DisplayView {
    
    override func initDisplayView(){
        super.initDisplayView()
        self.audio = BattleAudio()
    }

    override public func loadAnimateEvent(event: EventType.Animate?) {
        switch event {
        case .battleScene:
            self.imageView.alpha = 0
            super.loadAnimateEvent(event: .auto)
            
        case .respawnMonster:
            self.animateRespawnMonster()
            
        case .deathMonster:
            self.animateDeathMonster()
            
        case .attackMonster:
            self.animateAttackMonster()
            
        case .walkPlayer:
            self.imageView.alpha = 0
            super.loadAnimateEvent(event: .auto)
            
        case .attackPlayer:
            self.animateAttackPlayer()
            
        case .escapePlayer:
            self.animateEscapePlayer()
            
        case .levelUpPlayer:
            self.animateLevelUpPlayer()
            
        case .deathPlayer:
            self.animateDeathPlayer()
            
        default:
            super.loadAnimateEvent(event: event)
        }
    }
    
    private func animateRespawnMonster() {
        self.textButton.isEnabled = false
        UIView.animate(withDuration: 0.5, delay: 0.8, animations: {
            self.imageView.alpha = 1.0
        }, completion: { _ in
            self.animateCompletion()
        })
    }
    
    private func animateDeathMonster(){
        self.textButton.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            (self.audio as? BattleAudio)?.deathMonster()
        }
        UIView.animate(withDuration: 0.5, delay: 0.8, animations: {
            self.imageView.alpha = 0
        }, completion: { _ in
            self.animateCompletion()
        })
    }
    
    private func animateAttackMonster(){
        self.textButton.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            (self.audio as? BattleAudio)?.attackMonster()
        }
        UIView.animateKeyframes(withDuration: 0.3, delay: 0.8, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.33, animations: {
                self.imageView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.33, relativeDuration: 0.66, animations: {
                self.imageView.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
        }, completion: { _ in
            self.animateCompletion()
        })
    }
    
    private func animateEscapePlayer(){
        self.textButton.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            (self.audio as? BattleAudio)?.escapePlayer()
        }
        UIView.animate(withDuration: 0.5, delay: 0.8, animations: {
            self.imageView.center.x -= self.imageView.bounds.width
            self.imageView.alpha = 0
        }, completion: { _ in
            self.imageView.center.x += self.imageView.bounds.width
            self.animateCompletion()
        })
    }
    
    private func animateAttackPlayer(){
        self.textButton.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            (self.audio as? BattleAudio)?.attackPlayer()
        }
        UIView.animateKeyframes(withDuration: 0.3, delay: 0.8, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.33, animations: {
                self.imageView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.33, relativeDuration: 0.66, animations: {
                self.imageView.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
        }, completion:{ _ in
            self.animateCompletion()
        })
    }
    
    private func animateLevelUpPlayer(){
        self.textButton.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            (self.audio as? BattleAudio)?.levelUpPlayer()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
            self.animateCompletion()
        }
    }
    
    private func animateDeathPlayer(){
        self.textButton.isEnabled = false
        self.backImageView.addSubview(self.imageView)
        UIView.animate(withDuration: 0.3, delay: 0.8, animations: {
            self.backImageView.transform = CGAffineTransformMakeRotation(.pi/2)
        }, completion: { _ in
            self.animateCompletion()
        })
    }
}
