//
//  ImagesCollectionViewCell.swift
//  DiaryCodeBased
//
//  Created by Junhee Yoon on 2022/08/21.
//

import UIKit
import SnapKit

class ImagesCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    let imageView: CustomImageView = {
        let iv = CustomImageView(frame: .zero, contentMode: .scaleAspectFill)
        return iv
    }()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Helper Functions
    
    func setUI() {
        [imageView].forEach { self.addSubview($0) }
    }
    
    func setConstraints() {
        imageView.snp.makeConstraints { $0.top.trailing.leading.bottom.equalTo(self) }
    }
    
}
