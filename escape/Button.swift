//
//  Button.swift
//  onepMaker
//
//  Created by 小林千浩 on 2023/06/09.
//

import UIKit

@IBDesignable
class Button: UIButton {
    
    var delegate: ButtonProtocol?
    var audio = Audio()
    
    var value: Int?
    var flag: Bool?
    
    @IBInspectable var cornerRadius: CGFloat {
        get{
            self.layer.cornerRadius
        }
        
        set{
            self.layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get{
            self.layer.borderWidth
        }
        
        set{
            self.layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get{
            UIColor(cgColor: self.layer.borderColor ?? UIColor.white.cgColor)
        }
        
        set{
            self.layer.borderColor = newValue.cgColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initButton()
    }
    
    override func setTitle(_ title: String?, for state: UIControl.State) {
        if #available(iOS 15.0, *) {
            self.configuration = nil
        }
        if let dotFont = UIFont(name: "JF-Dot-k12x10", size: 20){
            self.titleLabel?.font = dotFont
        }
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        super.setTitle(title, for: state)
    }
    
    public func initButton(){
        self.addTarget(self, action: #selector(tappedButton(_:)), for: .touchUpInside)
    }
    
    @objc public func tappedButton(_ sender: UIButton){
        self.tappedSoundEffect()
        guard let delegate = self.delegate else {
            return
        }
        delegate.tappedButton(self)
    }
    
    public func tappedSoundEffect(){
        self.audio.buttonTapped()
    }
}
