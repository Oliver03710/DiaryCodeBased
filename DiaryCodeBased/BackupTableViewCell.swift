//
//  BackupTableViewCell.swift
//  DiaryCodeBased
//
//  Created by Junhee Yoon on 2022/08/24.
//

import UIKit

import SnapKit

class BackupTableViewCell: CustomTableViewCell {

    // MARK: - Properties
    
    let backupLabel: CustomLabel = {
        let label = CustomLabel(fontSize: 15, textAlignment: .center)
        return label
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Helper Functions
    
    override func setUI() {
        [backupLabel].forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        backupLabel.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(self)
        }
    }

}
