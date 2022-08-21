//
//  CustomTextView.swift
//  DiaryCodeBased
//
//  Created by Junhee Yoon on 2022/08/21.
//

import UIKit

class CustomTextView: UITextView {
    
    override func layoutSubviews() {
        self.layer.borderWidth = 1
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
    }
    
    convenience init(borderColor: CGColor) {
        self.init()
        self.layer.borderColor = borderColor
    }

}
