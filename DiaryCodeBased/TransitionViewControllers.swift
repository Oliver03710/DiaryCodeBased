//
//  TransitionViewControllers.swift
//  DiaryCodeBased
//
//  Created by Junhee Yoon on 2022/08/21.
//

import UIKit

extension UIViewController {
    
    func transitionViewController<T: UIViewController>(viewController vc: T.Type) {
        
        let vc =  T()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
        
    }
    
}
