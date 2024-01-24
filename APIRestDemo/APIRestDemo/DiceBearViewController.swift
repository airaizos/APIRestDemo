//
//  DiceBearViewController.swift
//  APIRestDemo
//
//  Created by Adrian Iraizos Mendoza on 24/1/24.
//

import UIKit

final class DiceBearViewController: UIViewController {
    //MARK: Outlets
    
    @IBOutlet weak var emojiImage: UIImageView!
    @IBOutlet weak var emojiCollectionView: UICollectionView!
    @IBOutlet weak var eyesPicker: UIPickerView!
    @IBOutlet weak var mouthPicker: UIPickerView!
    @IBAction func backgroundType(_ sender: UISegmentedControl) {
        viewLogic.backgroundSelection(atIndex:sender.selectedSegmentIndex)
    }
    @IBOutlet weak var primaryColorPicker: UIColorWell!
    @IBOutlet weak var secondaryColorPicker: UIColorWell!
    
    
    let modelLogic = DiceBearModelLogic.shared
    let viewLogic = DiceBearViewLogic.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eyesPicker.delegate = self
        eyesPicker.dataSource = self
        mouthPicker.delegate = self
        mouthPicker.dataSource = self
        
        primaryColorPicker.addTarget(self, action: #selector(primaryColorSelected), for: .valueChanged)
        
        secondaryColorPicker.addTarget(self, action: #selector(secondaryColorSelected), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewLogic.randomEmoji()
        getEmojiImage()
    }
    
    //MARK: IBActions
    @IBAction func refreshButton(_ sender: UIButton) {
        let model = DiceBearModel(funEmojiWithBackgroundColor: "CD5C5C,6C3483", backgroundType: .gradient, eyes: .love, mouth: .pissed)
        viewLogic.updateEmoji(params: model)
        getEmojiImage()
    }
    
    @IBAction func randomEmoji(_ sender: UIButton) {
        viewLogic.randomEmoji()
        getEmojiImage()
    }
    
    @IBAction func getMyEmojiTapped(_ sender: UIButton) {
        viewLogic.getMyEmoji()
        getEmojiImage()
    }
    
    //MARK: Métodos
    func getEmojiImage() {
        viewLogic.action = { [weak self] image in
            RunLoop.main.perform {
                self?.emojiImage.image = image
            }
        }
    }
    
    //MARK: Objc Métoodos
    @objc func primaryColorSelected(color: UIColorWell) {
        guard let color = color.selectedColor else { return }
        viewLogic.primaryColorSelection(color)
    }
    
    @objc func secondaryColorSelected(color: UIColorWell) {
        guard let color = color.selectedColor else { return }
        viewLogic.secondaryColorSelection(color)
    }
}


extension DiceBearViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case eyesPicker: viewLogic.getEyesComponentsCount()
        case mouthPicker: viewLogic.getMouthComponentsCount()
        default: 0
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case eyesPicker:  viewLogic.eyeSelection(atRow: row)
        case mouthPicker:  viewLogic.mouthSelection(atRow: row)
        default: ()
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case eyesPicker:  viewLogic.getEyeOptionLabel(atRow: row)
        case mouthPicker:  viewLogic.getMouthOptionLabel(atRow: row)
        default: ""
        }
    }
}
