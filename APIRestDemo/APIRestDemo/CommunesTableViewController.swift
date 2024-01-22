//
//  CommunesTableViewController.swift
//  APIRestDemo
//
//  Created by Adrian Iraizos Mendoza on 19/1/24.
//

import UIKit

final class CommunesTableViewController: UITableViewController {

    let modelLogic: CommunesModeLogic
    
    required init?(coder: NSCoder) {
        self.modelLogic = CommunesModeLogic.shared
        super.init(coder: coder)
    }
    
    var selectedDepartement: Departement? {
        didSet {
            NotificationCenter.default.addObserver(forName: .regions, object: nil, queue: .main) { _ in
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.clearsSelectionOnViewWillAppear = false
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        if let selectedDepartement {
            modelLogic.fetchCommunesFor(codeDepartement: selectedDepartement.code)
            self.navigationItem.title = selectedDepartement.nom
        }
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
        // Return false if you do not want the specified item to be editable.
        return true
    }
  

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            modelLogic.deleteCommuneFor(indexPath: indexPath)

        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        modelLogic.moveCommune(from: fromIndexPath, to: to)
    }


   
/*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
*/

}
