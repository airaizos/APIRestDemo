//
//  Extensions.swift
//  APIRestDemo
//
//  Created by Adrian Iraizos Mendoza on 23/1/24.
//

import UIKit

extension UIViewController {
    func goTo(viewControllerName: String){
        let storyboard = UIStoryboard(name: viewControllerName, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerName)
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func goToPresent(viewControllerName: String){
        let storyboard = UIStoryboard(name: viewControllerName, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerName)
        
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true)
    }
    
}


