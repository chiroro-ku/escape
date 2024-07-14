//
//  ViewController.swift
//  escape
//
//  Created by 小林千浩 on 2024/04/16.
//

import UIKit

class TitleViewController: EscapeViewController {
    
    let audio = Audio()

    @IBOutlet weak var settingView: UIView!
    @IBOutlet weak var startButton: Button!
    @IBOutlet weak var settingButton: Button!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.audio.buttonTapped()
        
        self.model = TitleModel()
        self.model.view = self
        self.model.load(value: 0)
        
        self.headerView.delegate = self
        self.headerView.load()
        
        self.displayView.delegate = self
        self.displayView.load(event: nil)
        
        self.startButton.delegate = self
        self.startButton.value = 1
        self.settingButton.delegate = self
        self.settingButton.value = 2
        
        _ = self.load()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.model = TitleModel()
        self.model.view = self
        self.model.load(value: 0)
    }
    
    override func tappedButton(_ button: Button) {
        
        guard let value = button.value else {
            return
        }
        
        if value == 1 {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let mainViewController = storyboard.instantiateViewController(withIdentifier: "main") as? EscapeViewController else {
                return
            }
            mainViewController.modalPresentationStyle = .fullScreen
            mainViewController.model = MainModel(model: self.model)
            mainViewController.model.view = mainViewController
            
            UIView.animate(withDuration: 1.0, delay: 0.45, animations: {
                self.coverView.alpha = 1.0
            }, completion: { _ in
                self.present(mainViewController, animated: false)
            })
            
        }else if value == 2 {
            
            if self.settingView.alpha == 1.0 {
                self.settingView.alpha = 0.0
            }else{
                self.settingView.alpha = 1.0
            }
            
        }
    }
}
