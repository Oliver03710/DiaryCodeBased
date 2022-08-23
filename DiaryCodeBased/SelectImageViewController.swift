//
//  SelectImageViewController.swift
//  DiaryCodeBased
//
//  Created by Junhee Yoon on 2022/08/21.
//

import UIKit

import Kingfisher

protocol TransferImageDelegate {
    func transferringImage(image: UIImage)
    func transferringPHPickerImage(image: UIImage?)
}

class SelectImageViewController: BaseViewController {

    // MARK: - Properties
    
    var selectView = SelectView()
    var delegate: TransferImageDelegate?
    
    // MARK: - Init
    
    override func loadView() {
        self.view = selectView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    // MARK: - Selectors
    
    @objc func selectImages() {
        guard let image = selectView.selectedImage else {
            delegate?.transferringPHPickerImage(image: selectView.phPickerImageView.image)
            selectView.phPickerImageView.isHidden = true
            self.navigationController?.popViewController(animated: true)
            selectView.phPickerImageView.image = nil
            return
        }
            delegate?.transferringImage(image: image)
            print(image)
        
        self.navigationController?.popViewController(animated: true)
        ImageData.imageData.removeAll()
    }
    
    @objc func goPhotoLibrary() {
        selectView.collectionView.isHidden = true
        ImageData.imageData.removeAll()
        present(selectView.phPicker, animated: true)
    }
    
    
    // MARK: - Helper Functions
    
    override func configureUI() {
        configureNavi()
    }
    
    func configureNavi() {
        self.showNaviBars(naviTitle: nil, naviBarTintColor: .systemGreen)
        let selectButton = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(selectImages))
        let phPicker = UIBarButtonItem(title: "사진첩", style: .plain, target: self, action: #selector(goPhotoLibrary))
        self.navigationItem.rightBarButtonItems = [selectButton, phPicker]
    }

}
