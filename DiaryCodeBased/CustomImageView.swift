//
//  CustomImageView.swift
//  DiaryCodeBased
//
//  Created by Junhee Yoon on 2022/08/21.
//

import UIKit

class CustomImageView: UIImageView {

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        self.backgroundColor = .lightGray
        self.layer.masksToBounds = true
    }
    
    convenience init(frame: CGRect, contentMode: UIView.ContentMode) {
        self.init(frame: frame)
        self.contentMode = contentMode
    }
    
}
