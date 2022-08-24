//
//  ViewController.swift
//  DiaryCodeBased
//
//  Created by Junhee Yoon on 2022/08/21.
//

import UIKit
import RealmSwift

protocol SendImageDelegate {
    func sendImage(image: UIImage)
}

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
        configureGestureRecognizers()
        showNaviBars(naviTitle: "MY DIARY", naviBarTintColor: .systemGreen)
        configureNaviButtons()
    }
    
    
    // MARK: - Selectors
    
    @objc func imageViewTapped() {
        let vc = SelectImageViewController()
        vc.delegate = self
        transitionViewController(vc, transitionStyle: .presentNavigation)
    }
    
    // Realm + 이미지 도큐먼트 저장
    @objc func saveButtonClicked() {
        
        // Record 추가
        guard let titleText = diaryView.titleTextField.text else { return }
        guard let contentText = diaryView.contentTextView.text else { return }
//        guard let dateText = diaryView.dateTextField.text?.toDate() else { return }
        let task = UserDiary(diaryTitle: titleText, contents: contentText, writingDate: Date(), registerDate: Date(), photos: nil)
        
        do {
            try localRealm.write {
                localRealm.add(task)
            }
        } catch let error {
            print(error)
        }
        
        if let image = diaryView.photoImageView.image {
            saveImageToDocument(fileName: "\(task.objectId).jpg", image: image)
        }
        
        dismiss(animated: true)
    }
    
    @objc func cancelButtonClicked() {
//        diaryView.photoImageView.image = nil
//        diaryView.titleTextField.text = nil
//        diaryView.dateTextField.text = nil
//        diaryView.contentTextView.text = nil
        dismiss(animated: true)
    }
    
    
    // MARK: - Helper Functions
    
    func configureGestureRecognizers() {
        diaryView.photoImageView.isUserInteractionEnabled = true
        let tapping = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        diaryView.photoImageView.addGestureRecognizer(tapping)
    }
    
    func configureNaviButtons() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(cancelButtonClicked))
        
    }
    
}


// MARK: - Extension: TransferImageDelegate

extension MainDiaryController: TransferImageDelegate {
    
    func transferringPHPickerImage(image: UIImage?) {
        diaryView.photoImageView.image = image
    }
    
    func transferringImage(image: UIImage) {
        diaryView.photoImageView.image = image
    }
    
}

// MARK: - Extension: SendImageDelegate

extension MainDiaryController: SendImageDelegate {
    
    func sendImage(image: UIImage) {
        diaryView.photoImageView.image = image
    }
    
}
