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
    
    
    let data: [Double] = [40, 8, 15, 80, 23, 42, 50, 51, 70]
    
    let linePlot = LinePlot(identifier: "line") // Identifier should be unique for each plot.
    let referenceLines = ReferenceLines()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
