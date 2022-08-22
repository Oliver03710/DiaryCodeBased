//
//  ViewController.swift
//  DiaryCodeBased
//
//  Created by Junhee Yoon on 2022/08/21.
//

import UIKit
import RealmSwift

class MainDiaryController: BaseViewController {

    // MARK: - Properties
    
    var diaryView = DiaryView()
    let localRealm = try! Realm()   // Realm 테이블에 데이터를 CRUD할 때, Realm 테이블 경로에 접근
    
    
    // MARK: - Init
    
    override func loadView() {
        self.view = diaryView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        print("Realm is located at:", localRealm.configuration.fileURL!)
    }
    
    override func configureUI() {
        diaryView.writeButton.addTarget(self, action: #selector(writeButtonClicked), for: .touchUpInside)
        configureGestureRecognizers()
        
    }
    
    
    // MARK: - Selectors
    
    @objc func imageViewTapped() {
        
        let vc = SelectImageViewController()
        vc.delegate = self
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
//        self.transitionViewController(viewController: SelectImageViewController.self)
    }
    
    @objc func writeButtonClicked() {
        
        // Record 추가
        let task = UserDiary(diaryTitle: "오늘의 일기\(Int.random(in: 1...1000))", contents: "일기 테스트 내용", writingDate: Date(), registerDate: Date(), photos: nil)
        
        try! localRealm.write {
            localRealm.add(task)    // Create
            print("Realm Succeed")
            dismiss(animated: true)
        }
        
    }
    
    
    // MARK: - Helper Functions
    
    func configureGestureRecognizers() {
        
        diaryView.photoImageView.isUserInteractionEnabled = true
        let tapping = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        diaryView.photoImageView.addGestureRecognizer(tapping)
    }
    
}


extension MainDiaryController: TransferImageDelegate {

    func transferringImage(image: UIImage) {
        diaryView.photoImageView.image = image
    }
        
}
