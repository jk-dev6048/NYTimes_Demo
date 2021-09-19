//
//  ArticleDetailController.swift
//  NYTimes
//
//  Created by Jayakrishnan NP on 19/09/21.
//

import UIKit
import  SwiftyJSON

class ArticleDetailController: UIViewController {

    var jsonObj: JSON? = nil
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelContent: UILabel!
    @IBOutlet weak var labelByLine: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let json = jsonObj {
            guard let title = json["title"].string else {
                return
            }
            guard let abstract = json["abstract"].string else {
                return
            }
            guard let byline = json["byline"].string else {
                return
            }
            labelTitle.text = title
            labelContent.text = abstract
            labelByLine.text = byline
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
