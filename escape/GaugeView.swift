//
//  GaugeView.swift
//  escape
//
//  Created by 小林千浩 on 2024/06/09.
//

import UIKit

@IBDesignable
class GaugeView: UIView {
    
    @IBInspectable var barViewColor: UIColor?{
        get{
            self.barView.backgroundColor
        }
        set{
            self.barView.backgroundColor = newValue
        }
    }
    
    private var barView: UIView = UIView()
    private var label: UILabel = UILabel()
    private var valueLabel: UILabel = UILabel()
    
    var delegate: GaugeViewProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initGaugeView()
        self.load()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initGaugeView()
        self.load()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.load()
    }
    
    public func load(){
        self.label.frame = self.bounds
        self.valueLabel.frame = self.bounds
        
        if let delegate = self.delegate {
            
            let ration = CGFloat(Float(delegate.value) / Float(delegate.maxValue))
            let width = self.bounds.width * ration
            
            UIView.animate(withDuration: 0.5, delay: 0.4, animations: {
                self.barView.frame = CGRect(x: self.bounds.origin.x, y: self.bounds.origin.y, width: width, height: self.bounds.height)
            })
            
            self.label.text = String("\(delegate.label)：")
            
            let valueLabelText = "\(delegate.value) / \(delegate.maxValue)"
            self.valueLabel.text = valueLabelText
        }else{
            self.barView.frame = self.bounds
        }
    }
    
    public func initGaugeView(){
        
        self.label.font = UIFont(name: "JF-Dot-k12x10", size: 20)
        self.valueLabel.font = UIFont(name: "JF-Dot-k12x10", size: 20)
        self.valueLabel.textAlignment = .right
        
        self.addSubview(self.barView)
        self.addSubview(self.label)
        self.addSubview(self.valueLabel)
    }
}
