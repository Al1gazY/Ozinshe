//
//  LogOutVC.swift
//  Ozinshe
//
//  Created by Aligazy Kismetov on 28.12.2022.
//

import UIKit

class LogOutVC: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var logoutbutton: UIButton!
    @IBOutlet weak var background: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }
    
    func configureView() {
        background.layer.cornerRadius = 32
        background.clipsToBounds = true
        background.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        logoutbutton.layer.cornerRadius = 12.0
    }
    
    @objc func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logout(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "accessToken")
        
        let rootVC = self.storyboard?.instantiateViewController(withIdentifier: "SingInNavigationController") as! UINavigationController
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = rootVC
        appDelegate.window?.makeKeyAndVisible()
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismissView()
    }
}
