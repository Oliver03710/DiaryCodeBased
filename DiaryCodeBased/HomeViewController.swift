//
//  HomeViewController.swift
//  DiaryCodeBased
//
//  Created by Junhee Yoon on 2022/08/22.
//

import UIKit
import SnapKit
import RealmSwift   // 1. import
import FSCalendar

class HomeViewController: BaseViewController {
    
    // MARK: - Properties
    
    // 즉시 실행 클로저
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.reuseIdentifier)
        return tv
    }()
    
    lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "다이어리 검색하세요"
        sb.delegate = self
        return sb
    }()
    
    let repository = UserDiaryRepository() // 2. Realm()
    
    var tasks: Results<UserDiary>! {
        didSet {
            tableView.reloadData()
            print("Tasks Changed")
        }
    }
    
    var filteredData: [UserDiary]?
    
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
        
        fetchRealm()
    }
    
    
    // MARK: - Selectors
    
    // Realm filter qeury, NSPredicate
    @objc func filterButtonClicked() {
        tasks = repository.fetchFilter()    // .filter("diaryTitle = '오늘의 일기993'")
    }
    
    @objc func sortButtonClicked() {
        tasks = repository.fetchSort("registeredDate")
    }
    
    @objc func plusButtonClicked() {
        let vc = MainDiaryController()
        transitionViewController(vc, transitionStyle: .presentFullNavigation)
    }
    
    @objc func backupButtonClicked() {
        let vc = BackupViewController()
        transitionViewController(vc, transitionStyle: .presentFullNavigation)
    }
    
    
    // MARK: - Helper Functions
    
    override func configureUI() {
        [searchBar, tableView].forEach { view.addSubview($0) }
        
        setNaviBarButtons()
    }
    
    override func setConstraints() {
        
        searchBar.snp.makeConstraints { make in
            make.leading.top.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        tableView.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(searchBar.snp.bottom)
        }
    }
    
    func fetchRealm() {
        // 3. Realm 데이터를 정렬해 tasks 에 담기
        tasks = repository.fetch()
    }
    
    func setNaviBarButtons() {
        let filterButton = UIBarButtonItem(title: "filter", style: .plain, target: self, action: #selector(filterButtonClicked))
        let sortButton = UIBarButtonItem(title: "sort", style: .plain, target: self, action: #selector(sortButtonClicked))
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusButtonClicked))
        let backupButton = UIBarButtonItem(image: UIImage(systemName: "tray.and.arrow.down.fill"), style: .plain, target: self, action: #selector(backupButtonClicked))
        
        navigationItem.leftBarButtonItems = [sortButton, filterButton]
        navigationItem.rightBarButtonItems = [addButton, backupButton]
    }
    
}


// MARK: - Extension: UITableViewDelegate, UITableViewDataSource

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let text = searchBar.text, let data = filteredData {
            if !text.isEmpty {
                return data.count
            }
        }
        
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.reuseIdentifier, for: indexPath) as? HomeTableViewCell else { return UITableViewCell() }
        
        if let text = searchBar.text, let data = filteredData {
            if !text.isEmpty {
                
            }
        } else {
            cell.sampleImageView.image = loadImageFromDocument(fileName: "\(tasks[indexPath.row].objectId).jpg")
            cell.titleLabel.text = tasks[indexPath.row].diaryTitle
            cell.dateLabel.text = tasks[indexPath.row].registerDate.toString()
            cell.sampleContentLabel.text = tasks[indexPath.row].contents
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = UIScreen.main.bounds.height / 6
        return height
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let favourite = UIContextualAction(style: .normal, title: "즐겨찾기") { action, view, completionHandler in
            
            // Realm Data Update
            self.repository.updateFavourite(item: self.tasks[indexPath.row])
            self.fetchRealm()
            
        }
        let image = tasks[indexPath.row].favourite ? "star.fill" : "star"
        favourite.image = UIImage(systemName: image)
        favourite.backgroundColor = .systemBlue
        
        return UISwipeActionsConfiguration(actions: [favourite])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        
        let delete = UIContextualAction(style: .destructive, title: "삭제") { action, view, completionHandler in
          
            self.repository.deleteItem(item: self.tasks[indexPath.row])
            self.fetchRealm()
            print("favourite Button Clicked")
            
        }
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
}


extension HomeViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = searchBar.text else { return }
        if !text.isEmpty, text.count > 0 {
            let result = tasks.where {
                $0.diaryTitle.contains(text) || $0.contents.contains(text)
            }
            filteredData?.append(contentsOf: result)
            tableView.reloadData()
        }
    }
    
}
