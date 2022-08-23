//
//  CustomLabel.swift
//  DiaryCodeBased
//
//  Created by Junhee Yoon on 2022/08/24.
//

import UIKit

class CustomLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(fontSize: CGFloat, textAlignment: NSTextAlignment) {
        self.init()
        self.font = .systemFont(ofSize: fontSize)
        self.textAlignment = textAlignment
    }

}
