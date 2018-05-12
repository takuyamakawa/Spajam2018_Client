//
//  List.swift
//  spajam2018
//
//  Created by 山川拓也 on 2018/05/12.
//  Copyright © 2018年 山川拓也. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class List: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var dataList: UITableView!
    
    let urlStr = "https://kentaiwami.jp/spajam2018/api/"
    var data = ["a","b", "c", "d","e"]
    var res = ["aaa", "aaa", "bbb", "ccc", "ddd"]
     var articles: [[String: String?]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataList.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
        
        dataList.frame = view.frame
        view.addSubview(dataList)
        dataList.delegate = self
        dataList.dataSource = self
        
        callAPI(name: "asd")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* リストの表示数を定義 */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    /* リスト一つ一つに写真やタイトルを配置する定義 */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /* セルの作成 */
        let cell = dataList.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        
        if !articles.isEmpty {
            let article = articles[indexPath.row]
            cell.dataLabel.text = article["date"]!
            cell.resultNumber.text = article["count"]!
        }
        
        
        
        return cell
    }
    
    /*
     セルの高さを設定
     */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    /* セルがタップされた時の処理 */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("タップされたセルのindex番号: \(indexPath.row)")
        
        //        appDelegate.area_name = areanames[indexPath.row]
        //
        let storyboard: UIStoryboard = UIStoryboard(name: "Detail", bundle: nil)
        let next: UIViewController = storyboard.instantiateInitialViewController()!
        present(next, animated: true, completion: nil)
    }
    
    public func callAPI(name: String){
        
        let APIUrl = urlStr + "walk/list?user_id=1"
        
        var request = URLRequest(url: URL(string: APIUrl)!)
        request.httpMethod = "GET"
        
        Alamofire.request(request as URLRequestConvertible)
            .responseJSON { response in
                
                guard let object = response.result.value else {
                    return
                }
                
                let json = JSON(object)
                let jsonarr = json["results"].arrayValue
                jsonarr.forEach { (json) in
                    let article: [String: String?] = [
                        "date": json["date"].string,
                        "count": json["count"].string
                    ]
                    self.articles.append(article)
                }
                print(self.articles)
                self.dataList.reloadData()
        }
    }
}
