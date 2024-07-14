//
//  MainViewController.swift
//  escape
//
//  Created by 小林千浩 on 2024/04/16.
//

import UIKit

class MainViewController: EscapeViewController {

    @IBOutlet weak var arrowImage: UIImageView!
    
    @IBOutlet weak var attackButton: Button!
    @IBOutlet weak var escapeButton: Button!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.model.load(value: 0)
        
        self.headerView.delegate = self
        self.headerView.load()
        
        self.displayView.delegate = self
        self.displayView.load(event: nil)
        
        self.attackButton.delegate = self
        self.attackButton.value = 1
        self.attackButton.isEnabled = false
        
        self.escapeButton.delegate = self
        self.escapeButton.value = 2
        self.escapeButton.isEnabled = false
        
        _ = self.load()
    }
    
    override public func load() -> EventType.Animate? {
        let animateEvent = super.load()
        switch animateEvent {
        case .systemTransition:
            UIView.animate(withDuration: 1.0, delay: 0.45, animations: {
                self.coverView.alpha = 1.0
            }, completion: { _ in
                self.dismiss(animated: false)
            })
            
        case .systemSelect:
            self.attackButton.isEnabled = true
            self.escapeButton.isEnabled = true
            self.displayView.load(event: nil)
            
        case .systemStress:
            self.arrowImage.alpha = 1.0
            UIView.animate(withDuration: 1.0, delay: 0.0, options: [.repeat, .autoreverse], animations: {
                self.arrowImage.frame.origin.y -= 10.0
            })
            self.displayView.load(event: nil)
            
        default:
            self.arrowImage.layer.removeAllAnimations()
            self.arrowImage.alpha = 0.0
            break
        }
        return animateEvent
    }
    
    override public func tappedButton(_ button: Button) {
        super.tappedButton(button)
        self.attackButton.isEnabled = false
        self.escapeButton.isEnabled = false
    }
}
