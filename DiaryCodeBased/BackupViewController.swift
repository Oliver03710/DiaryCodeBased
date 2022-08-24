//
//  BackupViewController.swift
//  DiaryCodeBased
//
//  Created by Junhee Yoon on 2022/08/24.
//

import UIKit

import SnapKit

class BackupViewController: BaseViewController {

    // MARK: - Init
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(BackupTableViewCell.self, forCellReuseIdentifier: BackupTableViewCell.reuseIdentifier)
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
    
    // MARK: - Selectors
    
    @objc func cancelButtonClicked() {
        dismiss(animated: true)
    }
    
    @objc func backupButtonClicked() {
        
    }
    
    @objc func restoreButtonClicked() {
        
    }
    
    
    // MARK: - Helper Functions
    
    override func configureUI() {
       setNaviBarButtons()
        configureTableView()
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { $0.edges.equalTo(view.safeAreaLayoutGuide) }
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
    }
    
    func setNaviBarButtons() {
        let xButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(cancelButtonClicked))
        let backupButton = UIBarButtonItem(title: "Backup", style: .plain, target: self, action: #selector(backupButtonClicked))
        let restoreButton = UIBarButtonItem(title: "Restore", style: .plain, target: self, action: #selector(restoreButtonClicked))
        
        navigationItem.leftBarButtonItems = [xButton]
        navigationItem.rightBarButtonItems = [backupButton, restoreButton]
    }
    
    
}


// MARK: - Extension: UITableViewDelegate

extension BackupViewController: UITableViewDelegate {
    
}


// MARK: - Extension: UITableViewDelegate

extension BackupViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BackupTableViewCell.reuseIdentifier, for: indexPath) as? BackupTableViewCell else { return UITableViewCell() }
        
        return cell
    }
    
}
