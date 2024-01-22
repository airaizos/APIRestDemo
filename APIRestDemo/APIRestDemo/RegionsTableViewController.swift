//
//  RegionsTableViewController.swift
//  APIRestDemo
//
//  Created by Adrian Iraizos Mendoza on 19/1/24.
//

import UIKit

final class RegionsTableViewController: UITableViewController {

    let modelLogic = CommunesModeLogic.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Al pulsar el detalle se siga mostrando la misma celda
        self.clearsSelectionOnViewWillAppear = false

        //Botón de editar
        self.navigationItem.rightBarButtonItem = self.editButtonItem
       
        ///Actualiza la tableView` cuando ha descargado las *regions*
        NotificationCenter.default.addObserver(forName: .regions, object: nil, queue: .main) { _ in
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
       true
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        modelLogic.getRegionsCount()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "regionCell", for: indexPath)

        let region = modelLogic.getRegionRow(indexPath: indexPath)
        var content = UIListContentConfiguration.subtitleCell()
        content.text = region.nom
        content.secondaryText = region.code
        
        cell.contentConfiguration = content
        
        return cell
    }

  
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            modelLogic.deleteRegion(indexPath: indexPath)
        }
    }
    

    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        modelLogic.moveRegion(indexPath: fromIndexPath, to: to)
    }
   
 
    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "segueToDepartements",
                let detail = segue.destination as? DepartementsTableViewController,
                let cell = sender as? UITableViewCell,
                let cellIndexPath = tableView.indexPath(for: cell) 
        else { return }
        
        let region = modelLogic.getRegionRow(indexPath: cellIndexPath)
        detail.selectedRegion = region
    }
 

}
