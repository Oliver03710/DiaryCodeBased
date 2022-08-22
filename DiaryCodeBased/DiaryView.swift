//
//  DiaryView.swift
//  DiaryCodeBased
//
//  Created by Junhee Yoon on 2022/08/21.
//

import UIKit
import SnapKit

class DiaryView: BaseView {

    // MARK: - Properties
    
    let photoImageView: CustomImageView = {
        let view = CustomImageView(frame: .zero, contentMode: .scaleAspectFill)
        return view
    }()
    
    let titleTextField: CustomTextField = {
        let tf = CustomTextField(palceHolder: "제목을 입력해주세요")
        return tf
    }()
    
    let dataTextField: CustomTextField = {
        let tf = CustomTextField(palceHolder: "날짜를 입력해주세요")
        return tf
    }()
    
    let contentTextView: CustomTextView = {
        let view = CustomTextView(borderColor: UIColor.black.cgColor)
        return view
    }()
    
    let writeButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .red
        btn.tintColor = .green
        return btn
    }()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // MARK: - Helper Functions
    
    override func configureUI() {
        [photoImageView, titleTextField, dataTextField, contentTextView].forEach { self.addSubview($0) }
        [writeButton].forEach { photoImageView.addSubview($0) }
    }
    
    override func setConstraints() {
        
        photoImageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(self).multipliedBy(0.3)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(20)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(50)
        }
        
        dataTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(20)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(50)
        }
        
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(dataTextField.snp.bottom).offset(20)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        writeButton.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.top)
            make.trailing.equalTo(photoImageView.snp.trailing)
        }
        
    }
    
}
