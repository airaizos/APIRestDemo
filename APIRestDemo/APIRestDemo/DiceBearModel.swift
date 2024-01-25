//
//  DiceBearModel.swift
//  APIRestDemo
//
//  Created by Adrian Iraizos Mendoza on 24/1/24.
//

import UIKit

struct DiceBearModel {
    
    static let funEmoji = DiceBearModel(design: .funEmoji)
    
    enum Design {
        case adventurer,funEmoji
        
        var style: String {
            switch self {
            case .adventurer: "adventurer/png"
            case .funEmoji: "fun-emoji/png"
            }
        }
    }
    
    enum BackgroundType: String,CaseIterable {
        case gradient = "gradientLinear", solid = "solid"
    }
    
    enum EyesType: String,CaseIterable {
        case closed = "closed", closed2 = "closed2", crying = "crying", cute = "cute", glasses  = "glasses", love = "love", pissed = "pissed", plan = "plain", sad = "sad", shades = "shades", sleepClose  = "sleepClose", stars = "stars", tearDrop = "tearDrop", wink = "wink", wink2 = "wink2"
        
    }
    
    enum MouthType: String,CaseIterable {
        case cute = "cute", drip = "drip", faceMask = "faceMask", kissHeart = "kissHeart", lilSmile = "lilSmile", pissed = "pissed", plain = "plain", sad = "sad", shout = "shout", shy = "shy", sick = "sick", smileLol = "smileLol", smileTeeth = "smileTeeth", tongueOut = "tongueOut", wideSmile = "wideSmile"
    }
    
    let design: Design
    //MARK: Options
    var backgroundType: BackgroundType = .solid
    var backgroundColor: String = "FFA07A"
    var eyes: EyesType = .closed
    var mouth: MouthType = .cute
    
    
    //MARK: QueryItems
    var backgroundTypeQueryItem: URLQueryItem {
        URLQueryItem(name: "backgroundType", value: backgroundType.rawValue)
    }
    var backgroundColorQueryItem: URLQueryItem {
        URLQueryItem(name: "backgroundColor", value: backgroundColor)
    }
    var eyesQueryItem: URLQueryItem {
        URLQueryItem(name: "eyes", value: eyes.rawValue)
    }
    var mouthQueryItem: URLQueryItem {
        URLQueryItem(name: "mouth", value: mouth.rawValue)
    }
    
   
    var url: URL {
        var first = URL.diceBearBaseURL.appending(path: design.style)
        first.append(queryItems: [backgroundTypeQueryItem,backgroundColorQueryItem,eyesQueryItem,mouthQueryItem])
        
        return first
    }
    
    init(design: Design) {
        self.design = design
    }
    
    init(funEmojiWithBackgroundColor: String, backgroundType: BackgroundType, eyes: EyesType, mouth : MouthType ) {
        self.design = .funEmoji
        self.backgroundColor = funEmojiWithBackgroundColor
        self.backgroundType = backgroundType
        self.eyes = eyes
        self.mouth = mouth
    }
    
}


extension DiceBearModel {
    static func randomModel() -> DiceBearModel {
        let backgroundType = BackgroundType.allCases.randomElement()!
    
        let primaryColor = randomHexColor
        let secondaryColor = randomHexColor
        
        let eyes = EyesType.allCases.randomElement()!
        let mouth = MouthType.allCases.randomElement()!
        return DiceBearModel(funEmojiWithBackgroundColor: backgroundType == .gradient
                             ? "\(primaryColor),\(secondaryColor)"
                             : primaryColor,
                      backgroundType: backgroundType,
                      eyes: eyes,
                      mouth: mouth)
    }
    
}


struct DiceBearAvatarModel {
    let id = UUID()
    let image: UIImage
    let details: String
}
