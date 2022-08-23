//
//  UIViewController+Extension.swift
//  DiaryCodeBased
//
//  Created by Junhee Yoon on 2022/08/23.
//

import UIKit

extension UIViewController {
    
    func showNaviBars( naviTitle: String?, naviBarTintColor: UIColor) {
        
        let barAppearance = UINavigationBarAppearance()
        barAppearance.backgroundColor = .systemBackground
        navigationItem.scrollEdgeAppearance = barAppearance
        
        navigationItem.title = naviTitle
        self.navigationController?.navigationBar.tintColor = naviBarTintColor
        
    }
    
    func transitionViewController<T: UIViewController>(viewController vc: T.Type) {
        
        let vc =  T()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
        
    }

}
