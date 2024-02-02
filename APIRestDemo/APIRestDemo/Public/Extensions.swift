//
//  Extensions.swift
//  APIRestDemo
//
//  Created by Adrian Iraizos Mendoza on 23/1/24.
//

import UIKit

extension UIViewController {
    func goTo(viewControllerName: String){
        let storyboard = UIStoryboard(name: viewControllerName, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerName)
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func goToPresent(viewControllerName: String){
        let storyboard = UIStoryboard(name: viewControllerName, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerName)
        
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true)
    }
}

var randomHexColor: String {
    let red = CGFloat.random(in: 0...1)
    let green = CGFloat.random(in: 0...1)
    let blue = CGFloat.random(in: 0...1)
    
    let randomColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    
    // Convertir el color a formato hexadecimal
    var redValue: CGFloat = 0.0
    var greenValue: CGFloat = 0.0
    var blueValue: CGFloat = 0.0
    var alphaValue: CGFloat = 0.0
    
    randomColor.getRed(&redValue, green: &greenValue, blue: &blueValue, alpha: &alphaValue)
    
    let redHex = String(format: "%02X", Int(redValue * 255))
    let greenHex = String(format: "%02X", Int(greenValue * 255))
    let blueHex = String(format: "%02X", Int(blueValue * 255))
    
    let hexColor = "\(redHex)\(greenHex)\(blueHex)"
    return hexColor
}


extension UIColor {
    
    //MARK: Convertir UIColor a Hex
    var toHexString: String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        return String(
            format: "%02X%02X%02X",
            Int(r * 0xff),
            Int(g * 0xff),
            Int(b * 0xff)
        )
    }
    
    //MARK: Convertir hex a Color
    convenience init(hex: String) {
        
        let scanner = Scanner(string: hex)
        //      scanner.scanLocation = 0
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = (rgbValue & 0xff)
        
        self.init(
            red: CGFloat(r) / 255,
            green: CGFloat(g) / 255,
            blue: CGFloat(b) / 255,
            alpha: 1
        )
    }
}
