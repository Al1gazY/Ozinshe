//
//  RegisterVC.swift
//  Ozinshe
//
//  Created by Aligazy Kismetov on 29.12.2022.
//

import UIKit
import Localize_Swift
import Alamofire
import SwiftyJSON
import SVProgressHUD

class RegisterVC: UIViewController, LanguageProtocol {

    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var haveAccLabel: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var secondPassLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var secondPasswordTextField: TextFieldWithPadding!
    @IBOutlet weak var passwordTextField: TextFieldWithPadding!
    @IBOutlet weak var emailTextField: TextFieldWithPadding!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var headerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViews()
        
        hideKeyboardWhenTappedAround()
    }
    
    func configureViews(){
        emailTextField.layer.cornerRadius = 12
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.borderColor = UIColor(red: 0.9, green: 0.92, blue: 0.94, alpha: 1).cgColor
        
        passwordTextField.layer.cornerRadius = 12
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor(red: 0.9, green: 0.92, blue: 0.94, alpha: 1).cgColor
        
        secondPasswordTextField.layer.cornerRadius = 12
        secondPasswordTextField.layer.borderWidth = 1
        secondPasswordTextField.layer.borderColor = UIColor(red: 0.9, green: 0.92, blue: 0.94, alpha: 1).cgColor
        
        signUpButton.layer.cornerRadius = 12
        
        signUpButton.setTitle("REGISTER".localized(), for: .normal)
        signInButton.setTitle("ENTER".localized(), for: .normal)
        haveAccLabel.text = "HAVEACC".localized()
        secondPassLabel.text = "SECONDPASS".localized()
        passwordLabel.text = "PASS".localized()
        secondPasswordTextField.placeholder = "YOURPASS".localized()
        passwordTextField.placeholder = "YOURPASS".localized()
        emailTextField.placeholder = "YOUREMAIL".localized()
        secondLabel.text = "FILLIN".localized()
        headerLabel.text = "REGISTER".localized()
    }
    
    @IBAction func signUp(_ sender: Any) {
        let email = emailTextField.text!
        let password = passwordTextField.text!
        let secondPass = secondPasswordTextField.text!
        
        if email.isEmpty || password.isEmpty || secondPass.isEmpty { return }
        if ((password.elementsEqual(secondPass)) != true)
        {
            SVProgressHUD.showError(withStatus: "PASSNOTEQUAL".localized())
            return
        }
        
        SVProgressHUD.show()
        
        let parameters = ["email": email,
                          "password": password]
        
        AF.request(Urls.SIGN_UP_URL, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseData { responce in
            
            SVProgressHUD.dismiss()
            var resultString = ""
            if let data = responce.data{
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            
            if responce.response?.statusCode == 200{
                let json = JSON(responce.data!)
                print("JSON: \(json)")
                
                if let token = json["accessToken"].string{
                    Storage.sharedInstance.accessToken = token
                    UserDefaults.standard.set(token, forKey: "accessToken")
                    self.startApp()
                } else {
                    SVProgressHUD.showError(withStatus: "CONNECTION_ERROR".localized())
                }
            } else {
                var ErrorString = "CONNECTION_ERROR".localized()
                if let sCode = responce.response?.statusCode{
                    ErrorString = ErrorString + "\(sCode)"
                }
                ErrorString = ErrorString + " \(resultString)"
                SVProgressHUD.showError(withStatus: "\(ErrorString)")
            }
        }
    }
    
    func startApp(){
        let tableVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC")
        tableVC?.modalPresentationStyle = .fullScreen
        self.present(tableVC!, animated: true)
    }
    
    @IBAction func signIn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SingInNavigationController")
        vc?.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true)
    }
    
    @IBAction func showPass(_ sender: Any) {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
        secondPasswordTextField.isSecureTextEntry = !secondPasswordTextField.isSecureTextEntry
    }
    
    @IBAction func editingDidBegin(_ sender: TextFieldWithPadding) {
        sender.layer.borderColor = UIColor(red: 0.59, green: 0.33, blue: 0.94, alpha: 1).cgColor
    }
    
    @IBAction func editingDidEnd(_ sender: TextFieldWithPadding) {
        sender.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1).cgColor
    }
    
    func languageDidchange() {
        configureViews()
    }
    
    func hideKeyboardWhenTappedAround(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
}
