//
//  List.swift
//  spajam2018
//
//  Created by 山川拓也 on 2018/05/12.
//  Copyright © 2018年 山川拓也. All rights reserved.
//

import UIKit

class List: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var dataList: UITableView!
    
    let urlStr = "https://kentaiwami.jp/spajam2018/api/"
    var data = ["a","b", "c", "d","e"]
    var res = ["aaa", "aaa", "bbb", "ccc", "ddd"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callAPI(name: "asd")
        
        dataList.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
        
        dataList.delegate = self
        dataList.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* リストの表示数を定義 */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    /* リスト一つ一つに写真やタイトルを配置する定義 */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /* セルの作成 */
        let cell = dataList.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        
        cell.dataLabel.text = data[indexPath.row]
        cell.resultNumber.text = res[indexPath.row]
        
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
        let request = NSMutableURLRequest(url: NSURL(string: APIUrl)! as URL)
        
        // set the method(HTTP-GET)
        request.httpMethod = "GET"
        
        // use NSURLSessionDataTask
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            if (error == nil) {
                let result = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!
                //print(result)
                
                self.convert(result: result)
                
            } else {
                print("error")
            }
        })
        task.resume()
        
        //let jsonObj = try JSONSerialization.jsonObject(with: results, options: []) as! Dictionary<String, Any>
        //let results = jsonObj["results"] as! Dictionary<String, Any>!
        
    }
    
    private func convert(result: NSString) {
        if let data = result.data(using: String.Encoding.utf8.rawValue) {
            do {
                let JSONObject = try JSONSerialization.jsonObject(with: data, options: [])
                let hoge = JSONObject as! NSDictionary
                let hoge2 = hoge["results"] as! NSArray
                
                for hhh in hoge2 {
                    print(hhh)
                }
            } catch let error {
                print(error)
            }
        } else {
            print("Invalid string")
        }
    }
}
