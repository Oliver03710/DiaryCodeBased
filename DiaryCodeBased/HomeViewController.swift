//
//  HomeViewController.swift
//  DiaryCodeBased
//
//  Created by Junhee Yoon on 2022/08/22.
//

import UIKit
import SnapKit
import RealmSwift   // 1. import

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
    
    let localRealm = try! Realm()   // 2. Realm()
    var tasks: Results<UserDiary>! {
        didSet {
            tableView.reloadData()
            print("Tasks Changed")
        }
    }
    
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
        tasks = localRealm.objects(UserDiary.self).sorted(byKeyPath: "registerDate", ascending: true).filter("diaryTitle CONTAINS[c] 'a'")
//            .filter("diaryTitle = '오늘의 일기993'")
    }
    
    @objc func sortButtonClicked() {
        tasks = localRealm.objects(UserDiary.self).sorted(byKeyPath: "registerDate", ascending: true)
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
        view.addSubview(tableView)
        tableView.snp.makeConstraints { $0.edges.equalTo(view.safeAreaLayoutGuide) }
        setNaviBarButtons()
    }
    
    func fetchRealm() {
        // 3. Realm 데이터를 정렬해 tasks 에 담기
        tasks = localRealm.objects(UserDiary.self).sorted(byKeyPath: "writingDate", ascending: false)
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
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.reuseIdentifier, for: indexPath) as? HomeTableViewCell else { return UITableViewCell() }
        
        cell.sampleImageView.image = loadImageFromDocument(fileName: "\(tasks[indexPath.row].objectId).jpg")
        cell.titleLabel.text = tasks[indexPath.row].diaryTitle
        cell.dateLabel.text = tasks[indexPath.row].registerDate.toString()
        cell.sampleContentLabel.text = tasks[indexPath.row].contents
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = UIScreen.main.bounds.height / 6
        return height
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let favourite = UIContextualAction(style: .normal, title: "즐겨찾기") { action, view, completionHandler in
            
            // Realm data update
            try! self.localRealm.write {
                // 하나의 레코드에서 특정 컬럼 하나만 변경
//                self.tasks[indexPath.row].favourite = !self.tasks[indexPath.row].favourite
                
                // 하나의 테이블에 특정 컬럼 전체를 변경
//                self.tasks.setValue(true, forKey: "favourite")
                
                // 하나의 레코드에서 여러 컬럼들이 변경
//                self.localRealm.create(UserDiary.self, value: ["objectId": self.tasks[indexPath.row].objectId, "contents": "변경 테스트", "diaryTitle": "제목 변경"], update: .modified)
                
                print("Realm Update Succeed, reloadRows 필요")
            }
            
            // 1. 스와이프한 셀 하나만 ReloadRows 코드 구현 -> 상대적 효율성
            // 2. 데이터가 변경되었으니 다시 Realm에서 데이터 가지고 오기 -> didSet으로 일관적 형태로 갱신
            self.fetchRealm()
           
        }
        let image = tasks[indexPath.row].favourite ? "star.fill" : "star"
        favourite.image = UIImage(systemName: image)
        favourite.backgroundColor = .systemBlue
        
        return UISwipeActionsConfiguration(actions: [favourite])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let favourite = UIContextualAction(style: .destructive, title: "삭제") { action, view, completionHandler in
            try! self.localRealm.write {
                self.localRealm.delete(self.tasks[indexPath.row])
            }
            self.removeImageFromDocument(fileName: "\(self.tasks[indexPath.row].objectId).jpg")
            print("favourtie Button Clicked")
            self.fetchRealm()
        }
        
        return UISwipeActionsConfiguration(actions: [favourite])
    }
    
}
