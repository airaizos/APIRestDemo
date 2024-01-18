//
//  NumbersAPIViewController.swift
//  APIRestDemo
//
//  Created by Adrian Iraizos Mendoza on 17/1/24.
//

import UIKit

final class NumbersAPIViewController: UIViewController {
    
    let modelLogic = NumbersModelLogic.shared
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var binaryLabel: UILabel!
    @IBOutlet weak var romanLabel: UILabel!
    @IBOutlet weak var palindromeLabel: UILabel!
    @IBOutlet weak var primeLabel: UILabel!
    @IBOutlet weak var triangularLabel: UILabel!
    @IBOutlet weak var perfectLabel: UILabel!
    @IBOutlet weak var mersenneLabel: UILabel!
    @IBOutlet weak var fermatLabel: UILabel!
    @IBOutlet weak var fibonacciLabel: UILabel!
    @IBOutlet weak var digitsSumLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getNumber()
        addObserver()
    }
    
    func getNumber() {
        modelLogic.getNumber()
    }
    
    func addObserver() {
        NotificationCenter.default.addObserver(forName: .number, object: nil, queue: .main) { notification in
            guard let _ = notification.object as? Number else { return }
            self.updateLabels()
        }
    }
    
    func updateLabels() {
        numberLabel.text = modelLogic.number.numero
        binaryLabel.text = modelLogic.number.binario
        romanLabel.text = modelLogic.number.romano
        palindromeLabel.text = modelLogic.number.palindromo
        primeLabel.text = modelLogic.number.primo
        triangularLabel.text = modelLogic.number.triangular
        perfectLabel.text = modelLogic.number.perfecto
        mersenneLabel.text = modelLogic.number.mersenne
        fermatLabel.text = modelLogic.number.fermat
        fibonacciLabel.text = modelLogic.number.fibonacci
        digitsSumLabel.text = modelLogic.number.sumDigits
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .number, object: nil)
    }
}


extension Notification.Name {
    static let number = Notification.Name("NUMBER")
}
