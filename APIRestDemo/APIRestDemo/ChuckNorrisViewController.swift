//
//  ChuckNorrisViewController.swift
//  APIRestDemo
//
//  Created by Adrian Iraizos Mendoza on 23/1/24.
//

import UIKit

final class ChuckNorrisViewController: UIViewController {
    let modelLogic = ChuckNorrisModelLogic.shared
    

    @IBOutlet weak var categories: UILabel!
    @IBOutlet weak var jokeLabel: UILabel!
    
    @IBOutlet weak var favoritesJokesTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        modelLogic.getJoke()
        modelLogic.action = { [weak self] _ in
            RunLoop.main.perform {
                self?.updateLabel()
            }
            
        }
    }
    
    
    
    @IBAction func getNewJoke(_ sender: UIButton) {
        modelLogic.getJoke()
    }
    
    
    @IBAction func addToFavorites(_ sender: UIButton) {
        modelLogic.saveJoke()
    }
    
    
    func updateLabel() {
        jokeLabel.text = modelLogic.getLabel()
        categories.text = modelLogic.getCategories()
    }
    
}
