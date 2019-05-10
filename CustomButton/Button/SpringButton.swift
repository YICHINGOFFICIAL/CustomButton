//
//  SpringButton.swift
//  Button
//
//  Created by YICHING on 2019/5/10.
//  Copyright © 2019 yichingofficial. All rights reserved.
//

import Foundation
import UIKit

class SpringButton: UIButton {
    
    var isCurrentOutside = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addTarget(self, action: #selector(shrinkAllowAnimation), for: .touchDown)
        self.addTarget(self, action: #selector(restoreAllowAnimation), for: .touchUpInside)
        self.addTarget(self, action: #selector(restoreAllowAnimation), for: .touchUpOutside)
        self.addTarget(self, action: #selector(restore), for: .touchDragOutside)
        self.addTarget(self, action: #selector(shrink), for: .touchDragInside)
    }
    
    @objc func shrinkAllowAnimation(){
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.6),
                       initialSpringVelocity: CGFloat(25.0),
                       options: [.curveEaseOut, .allowUserInteraction],
                       animations: {
                        self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        })
    }
    
    @objc func restoreAllowAnimation(){
        UIView.animate(withDuration: 0.8,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.3),
                       initialSpringVelocity: CGFloat(45.0),
                       options: [.curveEaseIn, .allowUserInteraction],
                       animations: {
                        self.transform = CGAffineTransform.identity
        })
    }
    
    @objc func shrink(){
        if isCurrentOutside == true{
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: CGFloat(0.6),
                           initialSpringVelocity: CGFloat(15.0),
                           options: [.curveEaseOut],
                           animations: {
                            self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            }, completion: {_ in self.isCurrentOutside = false})
        }
    }
    
    @objc func restore(){
        if isCurrentOutside == false{
            UIView.animate(withDuration: 0.8,
                           delay: 0,
                           usingSpringWithDamping: CGFloat(0.3),
                           initialSpringVelocity: CGFloat(50.0),
                           options: [.curveEaseIn],
                           animations: {
                            self.transform = CGAffineTransform.identity
            },completion: {_ in self.isCurrentOutside = true})
        }
    }
    
    override var isHighlighted: Bool {
        didSet { if isHighlighted { isHighlighted = false } }
    }
}
