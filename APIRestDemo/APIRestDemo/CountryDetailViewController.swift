//
//  CountryDetailViewController.swift
//  APIRestDemo
//
//  Created by Adrian Iraizos Mendoza on 30/1/24.
//

import UIKit
import MapKit

final class CountryDetailViewController: UIViewController {
    
    let modelLogic: CountryModelLogic
    let viewLogic: CountryDetailViewLogic
    
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var countryFlagImage: UIImageView!
    @IBOutlet weak var regionsTableView: UITableView!
    @IBOutlet weak var citiesTableView: UITableView!
    @IBOutlet weak var map: MKMapView!
    
    required init?(coder: NSCoder) {
        self.modelLogic = CountryModelLogic.shared
        self.viewLogic = CountryDetailViewLogic.shared
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       setupView()
    }
    
    //MARK: ViewDidLoad
    func setupView() {
        regionsTableView.dataSource = self
        regionsTableView.delegate = self
        citiesTableView.delegate = self
        citiesTableView.dataSource = self
        
        if let country = modelLogic.getSelectedCountry() {
            self.navigationItem.title = country.name
            updateLabels(for: country)
            Task {
               await modelLogic.getRegionsForCountry(country)
            }
        }
        addObservers()
    }
    
    func updateLabels(for country: CountryInfoModel) {
        countryNameLabel.text = country.name
        countryFlagImage.image = modelLogic.getSelectedCountryFlag()
    }
    
    func addObservers() {
        NotificationCenter.default.addObserver(forName: .regions, object: nil, queue: .main) { _ in
            self.regionsTableView.reloadData()
        }
        NotificationCenter.default.addObserver(forName: .cities, object: nil, queue: .main) { _ in
            self.citiesTableView.reloadData()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .regions, object: nil)
        NotificationCenter.default.removeObserver(self, name: .cities, object: nil)
    }
}

//MARK: TableView
extension CountryDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case regionsTableView: modelLogic.getRegionsCount()
        case citiesTableView: modelLogic.getCitiesCount()
        default: 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var identifier = "countryRegionCell"
        var name = ""
       
        switch tableView {
        case regionsTableView:
            let labels = viewLogic.getCellForRegion(at: indexPath)
            identifier = labels.identifier
            name = labels.name
       
        case citiesTableView: 
            let labels = viewLogic.getCellForCity(at: indexPath)
            identifier = labels.identifier
            name = labels.name
        default: break
        }
        
        var content = UIListContentConfiguration.subtitleCell()
        content.text = name
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.contentConfiguration = content
        
        return cell
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch tableView {
        case regionsTableView:  modelLogic.didSelectRegion(at: indexPath)
            
        case citiesTableView: modelLogic.didSelectCity(at: indexPath)
        default: break
            
        }
       
    }
    
    
}
