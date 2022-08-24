//
//  HomeTableViewCell.swift
//  DiaryCodeBased
//
//  Created by Junhee Yoon on 2022/08/24.
//

import UIKit

import SnapKit

class HomeTableViewCell: CustomTableViewCell {

    // MARK: - Properties
    
    let sampleImageView: CustomImageView = {
        let iv = CustomImageView(frame: .zero, contentMode: .scaleAspectFill)
        iv.image = UIImage(systemName: "applelogo")
        return iv
    }()
    
    let titleLabel: CustomLabel = {
        let label = CustomLabel(fontSize: 16, textAlignment: .center)
        return label
    }()
    
    let dateLabel: CustomLabel = {
        let label = CustomLabel(fontSize: 16, textAlignment: .center)
        return label
    }()
    
    let sampleContentLabel: CustomLabel = {
        let label = CustomLabel(fontSize: 15, textAlignment: .center)
        label.numberOfLines = 0
        return label
    }()
    
    
    // MARK: - Init
    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    // MARK: - Helper Functions
    
    override func setUI() {
        [sampleImageView, titleLabel, dateLabel, sampleContentLabel].forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        sampleImageView.snp.makeConstraints { make in
            make.width.equalTo(sampleImageView.snp.height)
            make.leading.equalTo(self.snp.leading).offset(8)
            make.top.equalTo(self.snp.top).offset(8)
            make.bottom.equalTo(self.snp.bottom).offset(-8)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(sampleImageView.snp.height).multipliedBy(0.12)
            make.leading.equalTo(sampleImageView.snp.trailing).offset(8)
            make.top.equalTo(self.snp.top).offset(8)
            make.trailing.equalTo(self.snp.trailing).offset(-8)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.height.equalTo(sampleImageView.snp.height).multipliedBy(0.12)
            make.leading.equalTo(sampleImageView.snp.trailing).offset(8)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.trailing.equalTo(self.snp.trailing).offset(-8)
        }
        
        sampleContentLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self.snp.bottom).offset(-8)
            make.leading.equalTo(sampleImageView.snp.trailing).offset(8)
            make.top.equalTo(dateLabel.snp.bottom).offset(8)
            make.trailing.equalTo(self.snp.trailing).offset(-8)
        }
    }

}
