//
//  MainTabViewController.swift
//  DiaryCodeBased
//
//  Created by Junhee Yoon on 2022/08/26.
//

import UIKit

class MainTabViewController: UITabBarController {

    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVCs()
        tabBarAppearance()
    }
    
    
    // MARK: - Helper Functions
    
    func configureVCs() {
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        let calVC = UINavigationController(rootViewController: CalendarViewController())
        let settingVC = UINavigationController(rootViewController: SettingsViewController())
        
        homeVC.title = "일기목록"
        calVC.title = "달력"
        settingVC.title = "설정"
        
        self.setViewControllers([homeVC, calVC, settingVC], animated: true)
        
        guard let items = self.tabBar.items else { return }
        
        let images = ["house", "calendar", "gear"]
        
        for x in 0...2 {
            items[x].image = UIImage(systemName: images[x])
        }
    }
    
    func tabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.backgroundEffect = UIBlurEffect(style: .light)
        tabBar.scrollEdgeAppearance = appearance
    }
}


// MARK: - Extension: UITabBarControllerDelegate

extension MainTabViewController: UITabBarControllerDelegate {
    
}
