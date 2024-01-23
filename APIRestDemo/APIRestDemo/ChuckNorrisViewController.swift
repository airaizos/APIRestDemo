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
        jokeReceived()
        updateTableView()
        favoritesJokesTableView.delegate = self
        favoritesJokesTableView.dataSource = self
    }
    
    
    
    @IBAction func getNewJoke(_ sender: UIButton) {
        modelLogic.getJoke()
    }
    
    
    @IBAction func addToFavorites(_ sender: UIButton) {
        modelLogic.saveJoke()
    }
    
    func jokeReceived() {
        modelLogic.action = { [weak self] _ in
            RunLoop.main.perform {
                self?.updateLabel()
            }
        }
    }
    
    func updateTableView() {
        modelLogic.tableAction = { [weak self] _ in
            RunLoop.main.perform {
                self?.favoritesJokesTableView.reloadData()
            }
        }
    }
    
    func updateLabel() {
        jokeLabel.text = modelLogic.getLabel()
        categories.text = modelLogic.getCategories()
    }
    
}


extension ChuckNorrisViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        modelLogic.getRowsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chuckCell", for: indexPath)
        let joke = modelLogic.getJokeRow(at: indexPath)
        var content = UIListContentConfiguration.subtitleCell()
        
        content.text = joke.value
        content.secondaryText = joke.categoriesView
        cell.contentConfiguration = content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            modelLogic.deleteJoke(at: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        modelLogic.moveJoke(from: fromIndexPath, to: to)
    }
    
    
}
