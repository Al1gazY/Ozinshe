//
//  TabBarVC.swift
//  Ozinshe
//
//  Created by Aligazy Kismetov on 16.12.2022.
//

import UIKit

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let homeSelected = UIImage(named: "HomeSelected")?.withRenderingMode(.alwaysOriginal)
        let searchSelected = UIImage(named: "SearchSelected")?.withRenderingMode(.alwaysOriginal)
        let favoriteSelected = UIImage(named: "FavoriteSelected")?.withRenderingMode(.alwaysOriginal)
        let profileSelected = UIImage(named: "ProfileSelected")?.withRenderingMode(.alwaysOriginal)

        tabBar.items?[0].selectedImage = homeSelected
        tabBar.items?[1].selectedImage = searchSelected
        tabBar.items?[2].selectedImage = favoriteSelected
        tabBar.items?[3].selectedImage = profileSelected

    }

}
