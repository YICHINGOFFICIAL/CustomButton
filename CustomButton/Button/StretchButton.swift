//
//  StretchButton.swift
//  Button
//
//  Created by YICHING on 2019/5/10.
//  Copyright © 2019 yichingofficial. All rights reserved.
//

import Foundation
import UIKit

class StretchButton: UIButton {
    
    var isCurrentOutside = false
    var stretchView = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 0, height: 0)))
    var defaultColor = UIColor()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addTarget(self, action: #selector(shrinkAllowAnimation), for: .touchDown)
        self.addTarget(self, action: #selector(restoreAllowAnimation), for: .touchUpInside)
        self.addTarget(self, action: #selector(restoreAllowAnimation), for: .touchUpOutside)
        self.addTarget(self, action: #selector(restore), for: .touchDragOutside)
        self.addTarget(self, action: #selector(shrink), for: .touchDragInside)
        self.clipsToBounds = false
        defaultColor = self.backgroundColor!
        self.backgroundColor = UIColor.clear
        customStretchView()
    }
    
    func customStretchView(){
        stretchView.frame = self.frame
        stretchView.center = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        stretchView.layer.cornerRadius = self.layer.cornerRadius
        stretchView.backgroundColor = defaultColor
        stretchView.isUserInteractionEnabled = false

        self.addSubview(stretchView)
        self.sendSubviewToBack(stretchView)
        
        stretchView.translatesAutoresizingMaskIntoConstraints = false
        horizontalConstraint = NSLayoutConstraint(item: stretchView, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        verticalConstraint = NSLayoutConstraint(item: stretchView, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        widthConstraint = NSLayoutConstraint(item: stretchView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant: 0)
        heightConstraint = NSLayoutConstraint(item: stretchView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: 0)
        self.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    var horizontalConstraint = NSLayoutConstraint()
    var verticalConstraint = NSLayoutConstraint()
    var widthConstraint = NSLayoutConstraint()
    var heightConstraint = NSLayoutConstraint()

    @objc func shrinkAllowAnimation(){
        widthConstraint.constant = self.frame.width / 3
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.6),
                       initialSpringVelocity: CGFloat(25.0),
                       options: [.curveEaseOut, .allowUserInteraction],
                       animations: {
                        self.stretchView.backgroundColor = self.defaultColor
                        self.layoutIfNeeded()
        })
    }
    
    @objc func restoreAllowAnimation(){
        widthConstraint.constant = 0
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.6),
                       initialSpringVelocity: CGFloat(10.0),
                       options: [.curveEaseIn, .allowUserInteraction],
                       animations: {
                        self.stretchView.backgroundColor = self.defaultColor
                        self.layoutIfNeeded()
        })
    }
    
    @objc func shrink(){
        if isCurrentOutside == true{
            widthConstraint.constant = self.frame.width / 3
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: CGFloat(0.6),
                           initialSpringVelocity: CGFloat(15.0),
                           options: [.curveEaseOut],
                           animations: {
                            self.stretchView.backgroundColor = self.defaultColor
                            self.layoutIfNeeded()
            }, completion: {_ in self.isCurrentOutside = false})
        }
    }
    
    @objc func restore(){
        if isCurrentOutside == false{
            widthConstraint.constant = 0
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: CGFloat(0.6),
                           initialSpringVelocity: CGFloat(15.0),
                           options: [.curveEaseIn],
                           animations: {
                            self.stretchView.backgroundColor = self.defaultColor
                            self.layoutIfNeeded()
            },completion: {_ in self.isCurrentOutside = true})
        }
    }
    
    
    override var isHighlighted: Bool {
        didSet { if isHighlighted { isHighlighted = false } }
    }
}
