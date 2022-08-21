//
//  CustomTextField.swift
//  DiaryCodeBased
//
//  Created by Junhee Yoon on 2022/08/21.
//

import UIKit

class BlackRadiusTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        backgroundColor = .clear
        textAlignment = .center
        borderStyle = .none
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
    }
    
    convenience init(palceHolder: String) {
        self.init()
        self.placeholder = placeholder
    }

}
