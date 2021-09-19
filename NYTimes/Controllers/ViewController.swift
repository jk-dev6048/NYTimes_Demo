//
//  ViewController.swift
//  NYTimes
//
//  Created by Jayakrishnan NP on 18/09/21.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var tableNewsArticles: UITableView!
    var articlesArray: [Article] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableNewsArticles.dataSource = self
        tableNewsArticles.delegate = self
        fetchMostViewedNewsReports { sts, articlesArr in
            if sts{
                self.articlesArray = articlesArr
                self.tableNewsArticles.reloadData()
                self.reloadInputViews()
            } else{
                debugPrint("Failed to fetch data.")
            }
        }
    }

    func fetchMostViewedNewsReports(completionHandler: @escaping (Bool, [Article])->(Void)){
        Alamofire.request(Constants.UrlStrings.DATA_URL, method: .get).responseJSON { response in
            debugPrint(response)
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let list: Array<JSON> = json["results"].arrayValue // If not an Array or nil, return []
                var results: [Article] = []
                DispatchQueue.main.async {
                    for jsonObj in list {
                        guard let title = jsonObj["abstract"].string else {
                            return
                        }
                        guard let author = jsonObj["byline"].string else{
                            return
                        }
                        guard let date = jsonObj["published_date"].string else{
                            return
                        }
                        
                        let articleObj = Article(title: title, author: author, date: date, json: jsonObj)
                        results.append(articleObj)
                    }
                    completionHandler(true, results)
                }
                
            case .failure(let error):
                print(error)
                completionHandler(false, [])
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articlesArray.count
    }

    private static let REUSABLE_CELL_IDENTIFIER: String = "TableArticleCellID"
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableNewsArticles.dequeueReusableCell(withIdentifier: ViewController.REUSABLE_CELL_IDENTIFIER) as! TableArticleCell
        cell.setData(article: articlesArray[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let articleVC = storyBoard.instantiateViewController(withIdentifier: "ArticleDetailControllerID") as! ArticleDetailController
        articleVC.jsonObj = articlesArray[indexPath.row].json
        self.navigationController?.pushViewController(articleVC, animated: true)
    }
}

