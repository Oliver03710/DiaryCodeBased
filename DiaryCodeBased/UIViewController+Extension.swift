//
//  UIViewController+Extension.swift
//  DiaryCodeBased
//
//  Created by Junhee Yoon on 2022/08/23.
//

import UIKit

extension UIViewController {
    
    enum TransitionStyle {
        case present
        case presentNavigation
        case presentFullNavigation
        case push
    }
    
    func showNaviBars( naviTitle: String?, naviBarTintColor: UIColor) {
        
        let barAppearance = UINavigationBarAppearance()
        barAppearance.backgroundColor = .systemBackground
        navigationItem.scrollEdgeAppearance = barAppearance
        
        navigationItem.title = naviTitle
        self.navigationController?.navigationBar.tintColor = naviBarTintColor
        
    }
    
    func transitionViewController<T: UIViewController>(_ viewController: T, transitionStyle: TransitionStyle = .present) {
        
         switch transitionStyle {
        case .present:
             self.present(viewController, animated: true)
        case .presentNavigation:
            let navi = UINavigationController(rootViewController: viewController)
             self.present(navi, animated: true)
        case .presentFullNavigation:
             let nav = UINavigationController(rootViewController: viewController)
             nav.modalPresentationStyle = .fullScreen
             self.present(nav, animated: true)
        case .push:
             self.navigationController?.pushViewController(viewController, animated: true)
        }
        
    }
    
    func showAlertMessage(title: String, button: String = "확인") {
        let okay = UIAlertAction(title: button, style: .default) { _ in
            
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(okay)
        alert.addAction(cancel)
        self.present(alert, animated: true)
        
    }

    
}
