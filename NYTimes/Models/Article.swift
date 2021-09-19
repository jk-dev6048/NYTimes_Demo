//
//  Article.swift
//  NYTimes
//
//  Created by Jayakrishnan NP on 19/09/21.
//

import Foundation
import SwiftyJSON

class Article {
    var title: String
    var author: String
    var date: String
    var json: JSON
    
    init(title:String, author:String, date:String, json:JSON) {
        self.title = title
        self.author = author
        self.date = date
        self.json = json
    }
}
