//
//  DepartementsTableViewController.swift
//  APIRestDemo
//
//  Created by Adrian Iraizos Mendoza on 19/1/24.
//

import UIKit
import Combine

final class DepartementsTableViewController: UITableViewController {
    
    let modelLogic: CommunesModeLogic
    private var subscribers = Set<AnyCancellable>()
    
    var selectedRegion: Region?
    
    required init?(coder: NSCoder) {
        self.modelLogic = CommunesModeLogic.shared
        super.init(coder: coder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearsSelectionOnViewWillAppear = false
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        if let selectedRegion {
            modelLogic.fetchDepartementsFor(codeRegion: selectedRegion.code)
            self.navigationItem.title = selectedRegion.nom
        }
        modelLogic.persistence.subject
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }.store(in: &subscribers)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        modelLogic.getDepartementsCountFor(region: selectedRegion)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "departementCell", for: indexPath)
        
        let departement = modelLogic.getDepartementRow(indexPath: indexPath)
        var content = UIListContentConfiguration.subtitleCell()
        content.text = departement.nom
        content.secondaryText = departement.code
        cell.contentConfiguration = content
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            modelLogic.deleteDepartement(indexPath: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        modelLogic.moveRegion(indexPath: fromIndexPath, to: to)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "segueToCommunes",
              let detail = segue.destination as? CommunesTableViewController,
              let cell = sender as? UITableViewCell,
              let cellIndexPath = tableView.indexPath(for: cell)
        else { return }
        let departement = modelLogic.getDepartementRow(indexPath: cellIndexPath)
        detail.selectedDepartement = departement
    }
    
    
}
