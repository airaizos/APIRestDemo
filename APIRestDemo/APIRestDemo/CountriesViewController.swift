//
//  CountriesViewController.swift
//  APIRestDemo
//
//  Created by Adrian Iraizos Mendoza on 30/1/24.
//

import UIKit

final class CountriesViewController: UIViewController {
    let modelLogic = CountryModelLogic.shared
    
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var countryFlagImage: UIImageView!
    @IBOutlet weak var countryCapitalLabel: UILabel!
    @IBOutlet weak var countryAreaLabel: UILabel!
    @IBOutlet weak var countryPopulationLabel: UILabel!
    @IBOutlet weak var countryBordersLabel: UILabel!
    @IBOutlet weak var countryTLDLabel: UILabel!
    @IBOutlet weak var countryCallingCodeLabel: UILabel!
    @IBOutlet weak var countryTimeZonesLabel: UILabel!
    
    @IBOutlet weak var countriesTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countriesTableView.delegate = self
        countriesTableView.dataSource = self
        
        NotificationCenter.default.addObserver(forName: .countries, object: nil, queue: .main) { _ in
            self.countriesTableView.reloadData()
        }
        NotificationCenter.default.addObserver(forName: .flag, object: nil, queue: .main) { _ in
            self.countriesTableView.reloadData()
        }
        
   
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .countries, object: nil)
        NotificationCenter.default.removeObserver(self, name: .flag, object: nil)
    }
}


extension CountriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        modelLogic.countriesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = countriesTableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath)
        let country = modelLogic.getCountryRow(at: indexPath)
        var content = UIListContentConfiguration.subtitleCell()
        content.text = country.name
        content.image = modelLogic.getCountryIcon(indexPath)
        cell.contentConfiguration = content
        
        Task {
            await modelLogic.downloadCountryIcon(indexPath)
        }
        return cell
    }
    
    
}
