//
//  CountryDetailViewController.swift
//  APIRestDemo
//
//  Created by Adrian Iraizos Mendoza on 30/1/24.
//

import UIKit

final class CountryDetailViewController: UIViewController {

    let modelLogic: CountryDetailModelLogic
    var selectedCountry: CountryInfoModel?
    
    required init?(coder: NSCoder) {
        self.modelLogic = CountryDetailModelLogic.shared
        super.init(coder: coder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let selectedCountry {
            self.navigationItem.title = selectedCountry.name
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
