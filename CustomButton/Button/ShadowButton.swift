//
//  ShadowButton.swift
//  Button
//
//  Created by YICHING on 2019/5/7.
//  Copyright © 2019 yichingofficial. All rights reserved.
//

import Foundation
import UIKit

class ShadowButton: UIButton {
    
    var isCurrentOutside = false
    var shadowView = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 3), size: CGSize(width: 0, height: 0)))
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addTarget(self, action: #selector(shrinkAllowAnimation), for: .touchDown)
        self.addTarget(self, action: #selector(restoreAllowAnimation), for: .touchUpInside)
        self.addTarget(self, action: #selector(restoreAllowAnimation), for: .touchUpOutside)
        self.addTarget(self, action: #selector(restore), for: .touchDragOutside)
        self.addTarget(self, action: #selector(shrink), for: .touchDragInside)
        
        customShadowView()
    }
    
    func customShadowView(){
        let backgroundView = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: self.frame.size))
        backgroundView.layer.cornerRadius = self.layer.cornerRadius
        backgroundView.backgroundColor = self.backgroundColor
        backgroundView.isUserInteractionEnabled = false
        self.addSubview(backgroundView)
        shadowView.frame.size = self.frame.size
        shadowView.layer.position.y += 3
        shadowView.layer.cornerRadius = self.layer.cornerRadius
        shadowView.backgroundColor = self.backgroundColor?.darker(by: 15)
        shadowView.isUserInteractionEnabled = false
        self.addSubview(shadowView)
        self.sendSubviewToBack(shadowView)
    }
    
    @objc func shrinkAllowAnimation(){
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.6),
                       initialSpringVelocity: CGFloat(25.0),
                       options: [.curveEaseOut, .allowUserInteraction],
                       animations: {
                        self.transform = CGAffineTransform(translationX: 0, y: 3)
                        self.shadowView.transform = CGAffineTransform(translationX: 0, y: -3)
        })
    }
    
    @objc func restoreAllowAnimation(){
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.6),
                       initialSpringVelocity: CGFloat(10.0),
                       options: [.curveEaseIn, .allowUserInteraction],
                       animations: {
                        self.transform = CGAffineTransform.identity
                        self.shadowView.transform = CGAffineTransform.identity
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
                            self.transform = CGAffineTransform(translationX: 0, y: 3)
                            self.shadowView.transform = CGAffineTransform(translationX: 0, y: -3)
            }, completion: {_ in self.isCurrentOutside = false})
        }
    }
    
    @objc func restore(){
        if isCurrentOutside == false{
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: CGFloat(0.6),
                           initialSpringVelocity: CGFloat(15.0),
                           options: [.curveEaseIn],
                           animations: {
                            self.transform = CGAffineTransform.identity
                            self.shadowView.transform = CGAffineTransform.identity
            },completion: {_ in self.isCurrentOutside = true})
        }
    }
    
    override var isHighlighted: Bool {
        didSet { if isHighlighted { isHighlighted = false } }
    }
}

extension UIColor {
    
    func lighter(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: abs(percentage) )
    }
    
    func darker(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: -1 * abs(percentage) )
    }
    
    func adjust(by percentage: CGFloat = 30.0) -> UIColor? {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(red: min(red + percentage/100, 1.0),
                           green: min(green + percentage/100, 1.0),
                           blue: min(blue + percentage/100, 1.0),
                           alpha: alpha)
        } else {
            return nil
        }
    }
}
