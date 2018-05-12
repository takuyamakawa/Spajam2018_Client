//
//  Detail.swift
//  spajam2018
//
//  Created by 山川拓也 on 2018/05/12.
//  Copyright © 2018年 山川拓也. All rights reserved.
//

import UIKit
import ScrollableGraphView

class Detail: UIViewController, ScrollableGraphViewDataSource{
    
    let urlStr = "https://kentaiwami.jp/spajam2018/api/"
    let data: [Double] = [40, 8, 15, 80, 23, 42, 50, 51, 70]
    
    let linePlot = LinePlot(identifier: "line") // Identifier should be unique for each plot.
    let referenceLines = ReferenceLines()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callAPI(name: "asd")
        
        let graphView = ScrollableGraphView(frame: CGRect(x: 0, y: 70, width: self.view.frame.width, height: 350), dataSource:self)
        
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
        
        //graphView.backgroundColor = UIColor.red
        graphView.backgroundFillColor = UIColor.init(red: 153/255, green: 153/255, blue: 153/255, alpha: 10/100)
        //graphView.backgroundFillColor = UIColor.brown
        
        
        graphView.addPlot(plot: linePlot)
        graphView.addReferenceLines(referenceLines: referenceLines)
        
        self.view.addSubview(graphView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func value(forPlot plot: Plot, atIndex pointIndex: Int) -> Double {
        // Return the data for each plot.
        switch(plot.identifier) {
        case "line":
            return data[pointIndex]
        default:
            return 0
        }
    }
    
    func label(atIndex pointIndex: Int) -> String {
        return "FEB \(pointIndex)"
    }
    
    func numberOfPoints() -> Int {
        return data.count
    }
    
    public func callAPI(name: String){
        
        // create the url-request GET
        /*let APIUrl = urlStr + "walk/prevwalk?user_id=1"
        let request = NSMutableURLRequest(url: NSURL(string: APIUrl)! as URL)
        
        // set the method(HTTP-GET)
        request.httpMethod = "GET"
        
        // use NSURLSessionDataTask
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            if (error == nil) {
                let result = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!
                print(result)
            } else {
                print("error")
            }
        })
        task.resume()*/
        
        // create the url-request PUT
        let APIUrl = urlStr + "walk"
        let myUrl:NSURL = NSURL(string: APIUrl)!
        
        //let _:Data = try! Data(contentsOf:myUrl as URL)
        let params:[String:Any] = ["walk_id": 5]
        
        let request = NSMutableURLRequest(url: myUrl as URL)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions(rawValue: 0))
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
            if let data = data, let response = response {
                print(response)
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
                    print(json)
                } catch {
                    print("Serialize Error")
                }
            } else {
                print(error ?? "Error")
            }
        }
        task.resume()
        
        
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
