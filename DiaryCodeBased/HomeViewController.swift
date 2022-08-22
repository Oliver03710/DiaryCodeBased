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
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .lightGray
        return tv
    }()
    
    let localRealm = try! Realm()   // 2. Realm()
    var tasks: Results<UserDiary>!
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 3. Realm 데이터를 정렬해 tasks 에 담기
        tasks = localRealm.objects(UserDiary.self).sorted(byKeyPath: "writingDate", ascending: false)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
        tasks = localRealm.objects(UserDiary.self).sorted(byKeyPath: "writingDate", ascending: false)
        tableView.reloadData()
    }
    
    
    // MARK: - Selectors
    
    @objc func plusButtonClicked() {
        let vc = MainDiaryController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
    // MARK: - Helper Functions
    
    override func configureUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        tableView.snp.makeConstraints { $0.edges.equalTo(view.safeAreaLayoutGuide) }
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusButtonClicked))
        navigationController?.navigationBar.isHidden = true
    }
    
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = tasks[indexPath.row].diaryTitle
        return cell
    }
    
}
