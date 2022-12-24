//
//  LanguageVC.swift
//  Ozinshe
//
//  Created by Aligazy Kismetov on 20.12.2022.
//

import UIKit
import Localize_Swift

protocol LanguageProtocol{
    func languageDidchange()
}
class LanguageVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var backgroundView: UIView!
    
    var delegate : LanguageProtocol
    
    let languageArray = [["English", "en"], ["Қазақша", "kk"], ["Русский", "ru"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        backgroundView.layer.cornerRadius = 32
        backgroundView.clipsToBounds = true
        backgroundView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        //Tap to dismiss LanguageVC
        
        let tap: UIGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissView(){
        self.dismiss(animated: true)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: backgroundView))!{
            return false
        }
        return true
    }
        //
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        languageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        let label = cell?.viewWithTag(1000) as! UILabel
        label.text = languageArray[indexPath.row][0]
        
        let checkImageView = cell?.viewWithTag(1001) as! UIImageView
        
        if Localize.currentLanguage() == languageArray[indexPath.row][1]{
            checkImageView.image = UIImage(named: "Check")
        } else {
            checkImageView.image = nil
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Localize.setCurrentLanguage(languageArray[indexPath.row][1])
        delegate.languageDidchange()
        dismiss(animated: true)
    }

}
