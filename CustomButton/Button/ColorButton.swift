//
//  ColorButton.swift
//  Button
//
//  Created by YICHING on 2019/5/7.
//  Copyright © 2019 yichingofficial. All rights reserved.
//

import Foundation
import UIKit

class ColorButton: UIButton {
    
    var isCurrentOutside = false
    var defaultColor = UIColor()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addTarget(self, action: #selector(shrinkAllowAnimation), for: .touchDown)
        self.addTarget(self, action: #selector(restoreAllowAnimation), for: .touchUpInside)
        self.addTarget(self, action: #selector(restoreAllowAnimation), for: .touchUpOutside)
        self.addTarget(self, action: #selector(restore), for: .touchDragOutside)
        self.addTarget(self, action: #selector(shrink), for: .touchDragInside)
        defaultColor = self.backgroundColor!
    }
    
    @objc func shrinkAllowAnimation(){
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(1),
                       initialSpringVelocity: CGFloat(25.0),
                       options: [.curveEaseOut, .allowUserInteraction],
                       animations: {
                        self.backgroundColor = self.defaultColor.darker(by: 15)
        })
    }
    
    @objc func restoreAllowAnimation(){
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(1),
                       initialSpringVelocity: CGFloat(10.0),
                       options: [.curveEaseIn, .allowUserInteraction],
                       animations: {
                        self.backgroundColor = self.defaultColor
        })
    }
    
    @objc func shrink(){
        if isCurrentOutside == true{
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: CGFloat(1),
                           initialSpringVelocity: CGFloat(15.0),
                           options: [.curveEaseOut],
                           animations: {
                            self.backgroundColor = self.defaultColor.darker(by: 15)
            }, completion: {_ in self.isCurrentOutside = false})
        }
    }
    
    @objc func restore(){
        if isCurrentOutside == false{
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: CGFloat(1),
                           initialSpringVelocity: CGFloat(15.0),
                           options: [.curveEaseIn],
                           animations: {
                            self.backgroundColor = self.defaultColor
            },completion: {_ in self.isCurrentOutside = true})
        }
    }
    
    override var isHighlighted: Bool {
        didSet { if isHighlighted { isHighlighted = false } }
    }
}
