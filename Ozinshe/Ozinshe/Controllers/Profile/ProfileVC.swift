//
//  ProfileVC.swift
//  Ozinshe
//
//  Created by Aligazy Kismetov on 20.12.2022.
//

import UIKit
import Localize_Swift
import Alamofire
import SwiftyJSON

class ProfileVC: UIViewController, LanguageProtocol {

    @IBOutlet weak var emailLabel: UILabel!
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
        
        let accessToken = Storage.sharedInstance.accessToken
        let headers: HTTPHeaders = [.authorization(bearerToken: accessToken)]
        
        AF.request("http://api.ozinshe.com/core/V1/user/profile", headers: headers).response { response in
            
            switch response.result{
                
            case .success(let value):
                let json = JSON(value)
                self.emailLabel.text = "\(json["user"]["email"])"
                
            case .failure(let error):
                print(error)
            }
        }
        
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
        languageVC.delegate = self // for language update in profile page
        present(languageVC, animated: true)
    }
    
    @IBAction func logout(_ sender: Any) {
        let logoutVC = storyboard?.instantiateViewController(withIdentifier: "LogOutVC") as! LogOutVC
        
        logoutVC.modalPresentationStyle = .overFullScreen
        
        present(logoutVC, animated: true, completion: nil)
    }
    func languageDidchange() {
        configureViews()
    }
    
}

