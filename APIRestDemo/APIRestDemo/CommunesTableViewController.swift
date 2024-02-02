//
//  CommunesTableViewController.swift
//  APIRestDemo
//
//  Created by Adrian Iraizos Mendoza on 19/1/24.
//

import UIKit
import Combine

final class CommunesTableViewController: UITableViewController {
    
    let modelLogic: CommunesModeLogic
    
    required init?(coder: NSCoder) {
        self.modelLogic = CommunesModeLogic.shared
        super.init(coder: coder)
    }
    private var subscribers = Set<AnyCancellable>()
    var selectedDepartement: Departement?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearsSelectionOnViewWillAppear = false
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        if let selectedDepartement {
            modelLogic.fetchCommunesFor(codeDepartement: selectedDepartement.code)
            self.navigationItem.title = selectedDepartement.nom
        }
        modelLogic.persistence.subject
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }.store(in: &subscribers)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        modelLogic.getCommunesCountFor(departement: selectedDepartement)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "communeCell", for: indexPath)
        
        let commune = modelLogic.getCommuneRow(indexPath: indexPath)
        var content = UIListContentConfiguration.subtitleCell()
        content.text = commune.nom
        content.secondaryText = commune.populationText
        cell.contentConfiguration = content
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            modelLogic.deleteCommuneFor(indexPath: indexPath)
            
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        modelLogic.moveCommune(from: fromIndexPath, to: to)
    }
    
}
