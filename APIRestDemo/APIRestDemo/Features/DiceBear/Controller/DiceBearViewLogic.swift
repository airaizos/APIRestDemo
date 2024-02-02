//
//  DiceBearViewLogic.swift
//  APIRestDemo
//
//  Created by Adrian Iraizos Mendoza on 24/1/24.
//

import UIKit


final class DiceBearViewLogic {
    static let shared = DiceBearViewLogic()
    
    let modelLogic = DiceBearModelLogic.shared

    private(set) var backgroundTypeOptions = DiceBearModel.BackgroundType.allCases
    
    private(set) var eyesOptions = DiceBearModel.EyesType.allCases
    
    private(set) var mouthOptions = DiceBearModel.MouthType.allCases
    
    private var emojiImage: UIImage?
    
    var eyeSelection = DiceBearModel.EyesType.closed
    var mouthSelection = DiceBearModel.MouthType.cute
    var backgroundTypeSelection = DiceBearModel.BackgroundType.solid
    var primaryColorSelection = UIColor.init(hex: randomHexColor)
    var secondaryColorSelection = UIColor.init(hex: randomHexColor)
    
    func getEmoji() {
        Task {
            let emoji = try await self.modelLogic.getFunEmoji()
            NotificationCenter.default.post(name: .emojiChange, object: emoji)
        }
    }
    
    func updateEmoji(params model: DiceBearModel) {
        Task {
            let emoji = try await self.modelLogic.getEmoji(model: model)
            NotificationCenter.default.post(name: .emojiChange, object: emoji)
        }
    }
    
    func randomEmoji() {
        Task {
            let emoji = try await
            self.modelLogic.getRandomEmoji()
            NotificationCenter.default.post(name: .emojiChange, object: emoji)
        }
    }
    
    //MARK: Outlets
    func getEyesComponentsCount() -> Int {
        eyesOptions.count
    }
    
    func getEyeOptionLabel(atRow row: Int) -> String {
        eyesOptions[row].rawValue
    }
    
    func eyeSelection(atRow row: Int) {
        let value =  eyesOptions[row].rawValue
        eyeSelection = DiceBearModel.EyesType(rawValue: value) ?? .closed
    }
    
    func getMouthComponentsCount() -> Int {
        mouthOptions.count
    }
    
    func getMouthOptionLabel(atRow row: Int) -> String {
        mouthOptions[row].rawValue
    }
    
    func mouthSelection(atRow row: Int) {
        let value = mouthOptions[row].rawValue
        mouthSelection = DiceBearModel.MouthType(rawValue: value) ?? .cute
    }
    
    func getPickerViewComponentsCount() -> Int {
        1
    }
    
    func backgroundSelection(atIndex index:Int) {
        let value = index == 0 ? "gradientLinear" : "solid"
        backgroundTypeSelection = DiceBearModel.BackgroundType(rawValue: value) ?? .solid
    }
    
    func primaryColorSelection(_ color: UIColor) {
        primaryColorSelection = color
    }
    func secondaryColorSelection(_ color: UIColor) {
        secondaryColorSelection = color
    }
    
    func getMyEmoji() {
        let model = DiceBearModel(
            funEmojiWithBackgroundColor: backgroundTypeSelection == .gradient ? "\(primaryColorSelection.toHexString),\(secondaryColorSelection.toHexString)"
             : primaryColorSelection.toHexString,
            backgroundType: backgroundTypeSelection,
            eyes: eyeSelection,
            mouth: mouthSelection)
        Task {
            let emoji = try await
            self.modelLogic.refreshEmoji(params: model)
            NotificationCenter.default.post(name: .emojiChange, object: emoji)
        }
    }
    
    
    func addFavoriteEmoji(image: UIImage) {
        let details = [backgroundTypeSelection.rawValue,primaryColorSelection.toHexString,secondaryColorSelection.toHexString,eyeSelection.rawValue,mouthSelection.rawValue].joined(separator: ",")
        
        let favorite = DiceBearEmojiModel(image: image, details: details)
        
        do {
            try modelLogic.addFavorite(emoji: favorite)
        } catch let error {
            print("Error en pantalla: \(error)")
        }
    }
    
    //MARK: CollectionView
    func getFavoritesCount() -> Int {
        modelLogic.getFavoritesCount()
    }
    
    func getEmojiFrom(_ indexPath: IndexPath) -> UIImage? {
        modelLogic.getEmojiFrom(indexPath)
    }
}
