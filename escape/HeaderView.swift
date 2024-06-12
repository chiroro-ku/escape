//
//  HeaderView.swift
//  escape
//
//  Created by 小林千浩 on 2024/06/09.
//

import UIKit

@IBDesignable
class HeaderView: UIView, GaugeViewProtocol {

    @IBOutlet weak var playerLabel: Button!
    @IBOutlet weak var gaugeView: GaugeView!
    @IBOutlet weak var enemyLabel: Button!
    
    var label = "体力"
    
    var value: Int{
        self.delegate?.playerHp ?? 100
    }
    
    var maxValue: Int{
        self.delegate?.playerMaxHp ?? 100
    }
    
    var delegate: HeaderViewProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadNib()
        self.initHeaderView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.loadNib()
        self.initHeaderView()
    }
    
    public func loadNib() {
        guard let view = Bundle(for: type(of: self)).loadNibNamed("HeaderView", owner: self, options: nil)?.first as? UIView else {
            return
        }
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    public func initHeaderView(){
        self.gaugeView.delegate = self
    }
    
    public func load(){
        guard let delegate = self.delegate else {
            return
        }
        let playerLabelText = "\(delegate.playerName)　Lv. \(delegate.playerLv)"
        self.playerLabel.setTitle(playerLabelText, for: .normal)
        
        self.gaugeView.load()
        
        if let enemyName = delegate.enemyName {
            self.enemyLabel.setTitle("\(enemyName)", for: .normal)
        }else{
            self.enemyLabel.setTitle("-", for: .normal)
        }
    }

}
