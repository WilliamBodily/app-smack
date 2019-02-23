//
//  RoundedCornersButton.swift
//  Smack
//
//  Created by William Bodily on 2/7/19.
//  Copyright © 2019 William Bodily. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedCornersButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 3.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    override func awakeFromNib() {
        self.setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = cornerRadius
    }

}
