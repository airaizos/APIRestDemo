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
    }
   
    @IBAction func goToMarvelCharacters(_ sender: UIButton) {
    
    }
    @IBAction func goToCountries(_ sender: UIButton) {
        goTo(viewControllerName: "CountriesStoryboard")
    }
    
    
    @IBAction func goToDiceBear(_ sender: Any) {
        goTo(viewControllerName: "DiceBearStoryboard")
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



