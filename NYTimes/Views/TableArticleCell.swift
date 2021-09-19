//
//  TableArticleCell.swift
//  NYTimes
//
//  Created by Jayakrishnan NP on 19/09/21.
//

import UIKit

class TableArticleCell: UITableViewCell {

 
    @IBOutlet weak var labelContent: UILabel!
    @IBOutlet weak var labelAuthorName: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var circularView: UIView!
    
    func setData(article: Article){
        labelContent.text = article.title
        labelAuthorName.text = article.author
        labelDate.text = article.date
        self.circularView.layer.cornerRadius = self.circularView.frame.size.width / 2
    }

}
