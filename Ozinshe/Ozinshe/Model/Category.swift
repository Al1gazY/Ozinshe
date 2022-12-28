//
//  Category.swift
//  Ozinshe
//
//  Created by Aligazy Kismetov on 28.12.2022.
//

import Foundation
import SwiftyJSON

//   {
//      "id": 5,
//      "name": "Телехикаялар",
//      "fileId": null,
//      "link": "http://api.ozinshe.com/core/public/V1/show/null",
//      "movieCount": null
//    }

class Category {
    public var id: Int = 0
    public var name: String = ""
    public var link: String = ""
    
    init(json: JSON) {
        if let temp = json["id"].int {
            self.id = temp
        }
        if let temp = json["name"].string {
            self.name = temp
        }
        if let temp = json["link"].string {
            self.link = temp
        }
    }
}

