//
//  ViewController.swift
//  APIRestDemo
//
//  Created by Adrian Iraizos Mendoza on 17/1/24.
//

import UIKit

final class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var BattutaView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
  
    @IBAction func gotoCommunes(_ sender: UIButton) {
        goTo(viewControllerName: "CommunesStoryboard")
    }
    
    @IBAction func gotoNumbers(_ sender: UIButton) {
        goTo(viewControllerName: "NumbersStoryboard")
    }
}


//final class BattutaViewClass: UIView {
//    var action: () -> Void?
//
//    override init(frame: CGRect) {
//            super.init(frame: frame)
//            setupTapGesture()
//        }
//
//        required init?(coder aDecoder: NSCoder) {
//            super.init(coder: aDecoder)
//            setupTapGesture()
//        }
//
//        private func setupTapGesture() {
//            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
//            self.addGestureRecognizer(tapGesture)
//            self.isUserInteractionEnabled = true
//        }
//
//        @objc private func handleTap() {
//          action()
//        }
//
//}
//
//
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
