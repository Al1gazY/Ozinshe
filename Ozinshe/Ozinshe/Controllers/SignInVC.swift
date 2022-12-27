//
//  SignInVC.swift
//  Ozinshe
//
//  Created by Aligazy Kismetov on 25.12.2022.
//

import UIKit
import SVProgressHUD
import Alamofire
import SwiftyJSON

class SignInVC: UIViewController {

    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var passwordTextField: TextFieldWithPadding!
    @IBOutlet weak var emailTextField: TextFieldWithPadding!
    
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
        
        signInButton.layer.cornerRadius = 12
    }
    
    func hideKeyboardWhenTappedAround(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }

    @IBAction func TextFieldEditingDidBegin(_ sender: TextFieldWithPadding) {
        sender.layer.borderColor = UIColor(red: 0.59, green: 0.33, blue: 0.94, alpha: 1).cgColor
    }
    
    @IBAction func TextFieldEditingDidEnd(_ sender: TextFieldWithPadding) {
        sender.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1).cgColor
    }
    
    @IBAction func showPassword(_ sender: Any) {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
    }
    
    @IBAction func signIn(_ sender: Any) {
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        if email.isEmpty || password.isEmpty { return }
        
        SVProgressHUD.show()
        
        let parameters = ["email": email,
                          "password": password]
        
        AF.request(Urls.SIGN_IN_URL, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseData { responce in
            
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
}
