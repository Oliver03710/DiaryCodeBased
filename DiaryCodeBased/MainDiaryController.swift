//
//  ViewController.swift
//  DiaryCodeBased
//
//  Created by Junhee Yoon on 2022/08/21.
//

import UIKit

class MainDiaryController: BaseViewController {

    // MARK: - Properties
    
    var diaryView = DiaryView()
    
    
    // MARK: - Init
    
    override func loadView() {
        self.view = diaryView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func configureUI() {
        configureGestureRecognizers()
    }
    
    
    // MARK: - Selectors
    
    @objc func imageViewTapped() {
        self.transitionViewController(viewController: SelectImageViewController.self)
    }
    
    
    // MARK: - Helper Functions
    
    func configureGestureRecognizers() {
        
        diaryView.photoImageView.isUserInteractionEnabled = true
        let tapping = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        diaryView.photoImageView.addGestureRecognizer(tapping)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! SelectImageViewController
        destVC.delegate = self
    }
    
}


// MARK: - Extension: TransferImageDelegate

extension MainDiaryController: TransferImageDelegate {
    
    func transferringImage(image: UIImage) {
        diaryView.photoImageView.image = image
        print(image)
    }
    
}
