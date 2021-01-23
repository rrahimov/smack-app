//
//  RoundedButton.swift
//  Smack
//
//  Created by Ruhullah Rahimov on 20.01.21.
//

import UIKit

@IBDesignable

class RoundedButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 5 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    func setupView() {
        self.layer.cornerRadius = cornerRadius
    }
    
    override func awakeFromNib() {
        self.setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupView()
    }
}
