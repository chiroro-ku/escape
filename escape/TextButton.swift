//
//  TextButton.swift
//  Bouken
//
//  Created by 小林千浩 on 2023/10/26.
//

import Foundation
import UIKit

@IBDesignable
class TextButton: Button {
    
    override var isEnabled: Bool{
        didSet{
            if self.isEnabled {
                self.layer.borderColor = UIColor.white.cgColor
            }else{
                self.layer.borderColor = UIColor.gray.cgColor
            }
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
    
    override public func tappedSoundEffect() {
        self.audio.textButtonTapped()
    }
    
    public func setText(text: String){
        self.setTitle(" \(text) ", for: .normal)
    }
}
