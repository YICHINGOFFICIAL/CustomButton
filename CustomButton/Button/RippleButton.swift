//
//  RippleButton.swift
//  Button
//
//  Created by YICHING on 2019/5/7.
//  Copyright © 2019 yichingofficial. All rights reserved.
//

import Foundation
import UIKit

class RippleButton: UIButton {
    
    var isCurrentOutside = false
    var rippleView = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 0, height: 0)))

    override func awakeFromNib() {
        super.awakeFromNib()
        self.addTarget(self, action: #selector(shrinkAllowAnimation), for: .touchDown)
        self.addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
        self.addTarget(self, action: #selector(touchUpOutside), for: .touchUpOutside)
        self.addTarget(self, action: #selector(restore), for: .touchDragOutside)
        self.addTarget(self, action: #selector(shrink), for: .touchDragInside)
        self.clipsToBounds = true
        customRippleView()
    }
    
    func customRippleView(){
        let radius = sqrt((self.frame.width) * (self.frame.width) + (self.frame.height) * (self.frame.height)) + 5
        rippleView.frame.size = CGSize(width: radius, height: radius)
        rippleView.center = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        rippleView.layer.cornerRadius = radius / 2
        rippleView.backgroundColor = self.backgroundColor?.lighter(by: 15)
        rippleView.isUserInteractionEnabled = false
        rippleView.transform = CGAffineTransform(scaleX: 0, y: 0)
        self.addSubview(rippleView)
        self.sendSubviewToBack(rippleView)
    }
    
    
    @objc func shrinkAllowAnimation(){
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(1),
                       initialSpringVelocity: CGFloat(5.0),
                       options: [.curveEaseOut, .allowUserInteraction],
                       animations: {
                        self.rippleView.transform = CGAffineTransform.identity
        })
    }
    
    @objc func touchUpInside(){
        UIView.animate(withDuration: 0.5,
                       delay: 0.5,
                       usingSpringWithDamping: CGFloat(1),
                       initialSpringVelocity: CGFloat(5.0),
                       options: [.curveEaseOut, .allowUserInteraction],
                       animations: {
                        self.rippleView.transform = self.rippleView.transform.scaledBy(x: 0.01, y: 0.01)
        }, completion: {_ in
            self.rippleView.transform = CGAffineTransform(scaleX: 0, y: 0)
        })
    }
    
    @objc func touchUpOutside(){
        self.rippleView.transform = CGAffineTransform(scaleX: 0, y: 0)
    }
    
    @objc func shrink(){
        if isCurrentOutside == true{
            self.rippleView.transform = CGAffineTransform.identity
            self.isCurrentOutside = false
        }
    }
    
    @objc func restore(){
        if isCurrentOutside == false{
            self.rippleView.transform = CGAffineTransform(scaleX: 0, y: 0)
            self.isCurrentOutside = true
        }
    }
    
    override var isHighlighted: Bool {
        didSet { if isHighlighted { isHighlighted = false } }
    }
}
