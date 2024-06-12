//
//  DisplayViiew.swift
//  escape
//
//  Created by 小林千浩 on 2024/04/20.
//

import Foundation
import UIKit

@IBDesignable
class DisplayView: UIView, ButtonProtocol{
    
    var audio = Audio()
    
    var delegate: DisplayViewProtocol?
    
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textButton: TextButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadNib()
        self.initDisplayView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.loadNib()
        self.initDisplayView()
    }
    
    public func loadNib() {
        guard let view = Bundle(for: type(of: self)).loadNibNamed("DisplayView", owner: self, options: nil)?.first as? UIView else {
            return
        }
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    public func initDisplayView(){
        self.textButton.delegate = self
    }
    
    public func animateCompletion(){
        guard let delegate = self.delegate else{
            return
        }
        delegate.loadedAnimate()
    }
    
    public func tappedButton(_ button: Button) {
        guard let delegate = self.delegate, let textButton = button as? TextButton else {
            return
        }
        delegate.tappedTextButton(textButton)
    }
    
    public func load(event: EventType.Animate?){
        guard let delegate = self.delegate else {
            return
        }
        
        if let backImageName = delegate.backImageName {
            self.backImageView.image = UIImage(named: backImageName)
        }
        
        if let imageName = delegate.imageName {
            self.imageView.image = UIImage(named: imageName)
        }
        
        if let text = delegate.text {
            self.textButton.setText(text: text)
        }
        
        self.loadAnimateEvent(event: event)
    }
    
    public func loadAnimateEvent(event: EventType.Animate?){
        switch event {
        case .auto:
            self.textButton.isEnabled = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                self.audio.textButtonTapped()
                self.animateCompletion()
            }
        case nil:
            self.textButton.isEnabled = true
        default:
            break
        }
    }
}
