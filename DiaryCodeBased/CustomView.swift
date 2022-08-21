//
//  CustomView.swift
//  DiaryCodeBased
//
//  Created by Junhee Yoon on 2022/08/21.
//

import UIKit

class CustomView: BaseView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        self.layer.borderWidth = 1
    }
    
    convenience init(borderColor: CGColor) {
        self.init()
        self.layer.borderColor = borderColor
    }

}
