//
//  SelectVIew.swift
//  DiaryCodeBased
//
//  Created by Junhee Yoon on 2022/08/21.
//

import UIKit

import SnapKit

class SelectView: BaseView {

    // MARK: - Properties
    
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
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Helper Functions
    
    override func configureUI() {
        
        configureCollectionView()
        [searchBar, collectionView].forEach { self.addSubview($0) }
        
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
        
    }
    
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ImagesCollectionViewCell.self, forCellWithReuseIdentifier: ImagesCollectionViewCell.reuseIdentifier)
    }

}


// MARK: - Extension: UICollectionViewDelegate

extension SelectView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}


// MARK: - Extension: UICollectionViewDataSource

extension SelectView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImagesCollectionViewCell.reuseIdentifier, for: indexPath) as? ImagesCollectionViewCell else { return UICollectionViewCell() }
        
        cell.imageView.image = UIImage(systemName: "applelogo")
        
        return cell
    }
    
}
