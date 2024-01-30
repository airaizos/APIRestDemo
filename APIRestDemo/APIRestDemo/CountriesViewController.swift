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
        NotificationCenter.default.addObserver(forName: .selectedCountry, object: nil, queue: .main) { notification in
            if let country = notification.object as? CountryInfoModel {
                self.updateCountryLabel(country)
            }
        }
        NotificationCenter.default.addObserver(forName: .selectedFlag, object: nil, queue: .main) { notification in
            if let flag = notification.object as? UIImage {
                self.updateFlagLabel(flag)
            }
        }
   
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
                
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard segue.identifier == "segueToDepartements",
//              let detail = segue.destination as? DepartementsTableViewController,
//              let cell = sender as? UITableViewCell,
//              let cellIndexPath = tableView.indexPath(for: cell)
//        else { return }
//        
//        let region = modelLogic.getRegionRow(indexPath: cellIndexPath)
//        detail.selectedRegion = region
//    }
//    
    
    //MARK: Methods
    func updateCountryLabel(_ country: CountryInfoModel) {
        countryNameLabel.text = country.name
        countryCapitalLabel.text = country.capitalLabel
        countryAreaLabel.text = country.areaLabel
        countryPopulationLabel.text = country.populationLabel
        countryBordersLabel.text = country.bordersLabel
        countryTLDLabel.text = country.tldLabel
        countryCallingCodeLabel.text = country.callingcode
        countryTimeZonesLabel.text = country.timeZonesLabel
    }
    
    func updateFlagLabel(_ flag: UIImage) {
        countryFlagImage.image = flag
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .countries, object: nil)
        NotificationCenter.default.removeObserver(self, name: .flag, object: nil)
        NotificationCenter.default.removeObserver(self, name: .selectedCountry, object: nil)
        NotificationCenter.default.removeObserver(self, name: .selectedFlag, object: nil)
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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        modelLogic.didSelectCountry(at: indexPath)
        
    }
    
    func tableView(_ tableView: UITableView,     accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
        let viewControllerName = "CountryDetailStoryboard"
        let storyboard = UIStoryboard(name: viewControllerName, bundle: nil)
        if let detailViewController = storyboard.instantiateViewController(withIdentifier: viewControllerName) as? CountryDetailViewController {
            
            let country = modelLogic.getCountryRow(at: indexPath)
            detailViewController.selectedCountry = country
            
            self.navigationController?.pushViewController(detailViewController, animated: true)
            
          
        }
    }
    
}
