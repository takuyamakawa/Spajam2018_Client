//
//  Detail.swift
//  spajam2018
//
//  Created by 山川拓也 on 2018/05/12.
//  Copyright © 2018年 山川拓也. All rights reserved.
//

import UIKit
import ScrollableGraphView
import Alamofire
import SwiftyJSON

class Detail: UIViewController, ScrollableGraphViewDataSource{
    
    var id: Int = 0
    
    let urlStr = "https://kentaiwami.jp/spajam2018/api/"
    let data: [Double] = [40, 8, 15, 80, 23, 42, 50, 51, 70]
    var time_data:[String] = []
    var count_data:[Int] = []
    
    var time_articles: [[String: String?]] = []
    var count_articles: [[String: Int]] = []
    
    let linePlot = LinePlot(identifier: "line") // Identifier should be unique for each plot.
    let referenceLines = ReferenceLines()
    var graphView = ScrollableGraphView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callAPI(name: "asd")
        
        /*if !count_articles.isEmpty {
            let article = articles[indexPath.row]
            count_data = count_article["count"]!
        }*/
        
        
        graphView = ScrollableGraphView(frame: CGRect(x: 0, y: 70, width: self.view.frame.width, height: 430), dataSource:self)
        
        //graphView.shouldAnimateOnAdapt = false
        //graphView.shouldAnimateOnStartup = false
    
        
        linePlot.lineWidth = 5
        linePlot.lineColor = UIColor(red: 124/255, green: 185/255, blue: 50/255, alpha: 100/100)
        linePlot.adaptAnimationType = ScrollableGraphViewAnimationType.custom
        
        referenceLines.referenceLineLabelFont = UIFont.boldSystemFont(ofSize: 15)
        referenceLines.dataPointLabelFont = UIFont.boldSystemFont(ofSize: 10)
        referenceLines.referenceLineColor = UIColor.init(red: 124/255, green: 185/255, blue: 50/255, alpha: 70/100)
        referenceLines.referenceLineLabelColor = UIColor.init(red: 124/255, green: 185/255, blue: 50/255, alpha: 70/100)
        referenceLines.dataPointLabelColor = UIColor.init(red: 124/255, green: 185/255, blue: 50/255, alpha: 70/100)
        referenceLines.includeMinMax = false
        
        //graphView.backgroundColor = UIColor.red
        graphView.backgroundFillColor = UIColor.init(red: 153/255, green: 153/255, blue: 153/255, alpha: 10/100)
        //graphView.backgroundFillColor = UIColor.brown
        
        
        graphView.addPlot(plot: linePlot)
        graphView.addReferenceLines(referenceLines: referenceLines)
        
        graphView.rangeMax = 30
        graphView.rangeMin = 0
        
        print(id)
        //self.view.addSubview(graphView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    public func callAPI(name: String){
        
        var appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate

        print("HOHOHOHOHOHOHO")
        print(appDelegate.list_id)
        
        if((appDelegate.list_id) != nil){
            appDelegate.list_id=appDelegate.list_id!+0
        }else{
            appDelegate.list_id=30
        }
        
        // create the url-request PUT
        let APIUrl = urlStr + "walk/list/" + String(appDelegate.list_id!) + "?user_id=1"
        
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
                        "time": json["time"].string
                    ]
                    self.time_articles.append(article)
                    
                    let article2: [String: Int?] = [
                        "count": json["count"].int
                    ]
                    self.count_articles.append(article2 as! [String : Int])
                }
                
                for i in 0..<self.time_articles.count {
                    let article = self.time_articles[i]["time"]
                    self.time_data.append(article!!)
                    //print(self.time_data[i])
                }
                
                for i in 0..<self.count_articles.count {
                    let article = self.count_articles[i]["count"]
                    self.count_data.append(article!)
                    //print(self.count_data[i])
                }
                
                self.view.addSubview(self.graphView)
        }
        
        
        
    }
    
    func value(forPlot plot: Plot, atIndex pointIndex: Int) -> Double {
        // Return the data for each plot.
        switch(plot.identifier) {
        case "line":
            return Double(count_data[pointIndex])
        default:
            return 0
        }
    }
    
    func label(atIndex pointIndex: Int) -> String {
        return time_data[pointIndex]
    }
    
    func numberOfPoints() -> Int {
        return count_data.count
    }
    
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
