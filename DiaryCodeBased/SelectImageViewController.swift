//
//  SelectImageViewController.swift
//  DiaryCodeBased
//
//  Created by Junhee Yoon on 2022/08/21.
//

import UIKit

class SelectImageViewController: BaseViewController {

    // MARK: - Properties
    
    var selectView = SelectView()

    
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
        self.dismiss(animated: true)
    }
    
    @objc func goBack() {
        self.dismiss(animated: true)
    }
    
    
    // MARK: - Helper Functions
    
    override func configureUI() {
        configureNavi()
    }
    
    func configureNavi() {
        self.showNaviBars(naviTitle: nil, naviBarTintColor: .systemGreen)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(selectImages))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBack))
    }

}
