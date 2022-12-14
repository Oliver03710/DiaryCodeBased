//
//  SelectVIew.swift
//  DiaryCodeBased
//
//  Created by Junhee Yoon on 2022/08/21.
//

import UIKit
import PhotosUI

import Kingfisher
import SnapKit

class SelectView: BaseView {

    // MARK: - Properties
    
    var imageFromPHPicker: UIImage?
    var selectedImage: UIImage?
    var itemPrividers: [NSItemProvider] = []
    var iterator: IndexingIterator<[NSItemProvider]>?
    var selectIndexPath: IndexPath?
    
    lazy var phPicker: PHPickerViewController = {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        
        let phPicker = PHPickerViewController(configuration: configuration)
        phPicker.delegate = self
        return phPicker
    }()
    
    let searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.searchTextField.attributedPlaceholder = NSAttributedString(string: "사진을 검색하세요!", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray2])
        sb.backgroundColor = .white
        sb.searchTextField.backgroundColor = .white
        sb.searchTextField.leftView?.tintColor = .black
        return sb
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 2
        let width = UIScreen.main.bounds.width - (spacing * 4)

        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: width / 3, height: width / 3)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv

    }()
    
    let phPickerImageView: CustomImageView = {
        let iv = CustomImageView(frame: .zero, contentMode: .scaleAspectFill)
        iv.isHidden = true
        return iv
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
        configureSearchBar()
        configureCollectionView()
        [searchBar, collectionView, phPickerImageView].forEach { self.addSubview($0) }
        
    }
    
    override func setConstraints() {
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        phPickerImageView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(20)
            make.centerX.equalTo(self.safeAreaLayoutGuide)
            make.width.equalTo(UIScreen.main.bounds.width / 1.1)
            make.height.equalTo(phPickerImageView.snp.width).multipliedBy(1)
            
        }
        
    }
    
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ImagesCollectionViewCell.self, forCellWithReuseIdentifier: ImagesCollectionViewCell.reuseIdentifier)
    }
    
    func configureSearchBar() {
        searchBar.delegate = self
    }

}


// MARK: - Extension: UICollectionViewDelegate

extension SelectView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? ImagesCollectionViewCell else { return }
//        cell.layer.borderWidth = 3
//        cell.layer.borderColor = #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)
        
        selectedImage = cell.imageView.image
        selectIndexPath = indexPath
        collectionView.reloadData()
        
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? ImagesCollectionViewCell else { return }
        cell.layer.borderWidth = 0
        cell.layer.borderColor = nil
        collectionView.deselectItem(at: indexPath, animated: true)
        selectedImage = nil
        selectIndexPath = nil
        collectionView.reloadData()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? ImagesCollectionViewCell else { return }
        cell.contentView.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)

    }

    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? ImagesCollectionViewCell else { return }
        cell.contentView.backgroundColor = nil
        
    }
    
}


// MARK: - Extension: UICollectionViewDataSource

extension SelectView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ImageData.imageData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImagesCollectionViewCell.reuseIdentifier, for: indexPath) as? ImagesCollectionViewCell else { return UICollectionViewCell() }
        
        cell.layer.borderWidth = selectIndexPath == indexPath ? 4 : 0
        cell.layer.borderColor = selectIndexPath == indexPath ? #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1) : nil
        cell.imageView.kf.setImage(with: URL(string: ImageData.imageData[indexPath.item]))

        return cell
    }
    
}


// MARK: - Extension: UISearchBarDelegate

extension SelectView: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.phPickerImageView.image = nil
        self.phPickerImageView.isHidden = true
        if collectionView.isHidden {
            collectionView.isHidden = false
        }
        ImageData.imageData.removeAll()
        guard let text = searchBar.text else { return }
        if !text.isEmpty, text.count > 0 {
            FetchImageManager.shared.fetchImages(query: text) { urlArr in
                ImageData.imageData.append(contentsOf: urlArr)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    
                }
                
            }
        }
        
    }
    
}


// MARK: - Extension: PHPickerViewControllerDelegate

extension SelectView: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        phPicker.dismiss(animated: true)
        
        let itemProvider = results.first?.itemProvider
        
        if let itemProvider = itemProvider,
           
            itemProvider.canLoadObject(ofClass: UIImage.self) {
            
            itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                
                DispatchQueue.main.async {
                    self.phPickerImageView.image = image as? UIImage
                    self.phPickerImageView.isHidden = false
                }
                
            }
            
        } else {
            print("Error from Picking Photos")
            self.phPickerImageView.image = nil
            phPickerImageView.isHidden = true
        }
        
    }
    
}
