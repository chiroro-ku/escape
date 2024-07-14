//
//  Window.swift
//  escape
//
//  Created by 小林千浩 on 2024/07/14.
//

import UIKit

@IBDesignable
class WindowView: UIView {

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
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
