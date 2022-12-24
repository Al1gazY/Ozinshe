//
//  ProfileVC.swift
//  Ozinshe
//
//  Created by Aligazy Kismetov on 20.12.2022.
//

import UIKit
import Localize_Swift

class ProfileVC: UIViewController, LanguageProtocol {

    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var languageButton: UIButton!
    @IBOutlet weak var myProfileLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureViews()
    }
    
    func configureViews(){
        myProfileLabel.text = "MY_PROFILE".localized()
        languageButton.setTitle("LANGUAGE".localized(), for: .normal)
        
        if Localize.currentLanguage() == "ru"{
            languageLabel.text = "Русский"
        }
        if Localize.currentLanguage() == "kk"{
            languageLabel.text = "Қазақша"
        }
        if Localize.currentLanguage() == "en"{
            languageLabel.text = "English"
        }
    }
    
    @IBAction func languageShow(_ sender: Any) {
        let languageVC = storyboard?.instantiateViewController(withIdentifier: "LanguageVC") as! LanguageVC
        
        languageVC.modalPresentationStyle = .overFullScreen
        languageVC.delegate = self
        present(languageVC, animated: true)
    }
    
    func languageDidchange() {
        configureViews()
    }
    
}
