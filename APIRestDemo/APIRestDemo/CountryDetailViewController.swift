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
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var distanceFrom: UILabel!
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
        setLocationManager()
    }
    
    func updateLabels(for country: CountryInfoModel) {
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
    
    func setLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .regions, object: nil)
        NotificationCenter.default.removeObserver(self, name: .cities, object: nil)
        modelLogic.detailVCDisappear()
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
        var labels = (identifier:"",name:"")
        switch tableView {
        case regionsTableView: labels = viewLogic.getCellForRegion(at: indexPath)
        case citiesTableView:  labels = viewLogic.getCellForCity(at: indexPath)
        default: break
        }
        identifier = labels.identifier
        name = labels.name
        
        var content = UIListContentConfiguration.subtitleCell()
        content.text = name
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.contentConfiguration = content
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
        case regionsTableView:  modelLogic.didSelectRegion(at: indexPath)
        case citiesTableView: 
            let city = modelLogic.didSelectCity(at: indexPath)
            renderMap(city: city)
        default: break
            
        }
    }
}

//MARK: MapKit

extension CountryDetailViewController: CLLocationManagerDelegate {
    func renderMap(city: BattutaCityModel) {
        guard let cityLocation = getLocation(from: city) else { return }
        
        
        let coordenates = CLLocationCoordinate2D(latitude: cityLocation.coordinate.latitude, longitude: cityLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center: coordenates, latitudinalMeters: 10000, longitudinalMeters: 10000)
        map.setRegion(region, animated: true)
        
    }
    
    func getLocation(from city: BattutaCityModel) -> CLLocation? {
        guard let latitude = Double(city.latitude), let longitude = Double(city.longitude) else { return nil }
        let locationCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let location = CLLocation(latitude: locationCoordinate.latitude, longitude: locationCoordinate.longitude)
        
        return location
    }
    
}
