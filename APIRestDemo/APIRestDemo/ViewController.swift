//
//  ViewController.swift
//  APIRestDemo
//
//  Created by Adrian Iraizos Mendoza on 17/1/24.
//

import UIKit

final class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func goToChuckNorris(_ sender: UIButton) {
        goTo(viewControllerName: "ChuckNorrisStoryboard")
    }
    
    @IBAction func gotoCommunes(_ sender: UIButton) {
        goTo(viewControllerName: "CommunesStoryboard")
    }
    
    @IBAction func gotoNumbers(_ sender: UIButton) {
        goTo(viewControllerName: "NumbersStoryboard")
    }
}



