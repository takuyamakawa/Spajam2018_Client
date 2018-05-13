//
//  ViewController.swift
//  spajam2018
//
//  Created by 山川拓也 on 2018/05/08.
//  Copyright © 2018年 山川拓也. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    var timer: Timer?
    
    let urlStr = "https://kentaiwami.jp/spajam2018/api/"
    let param:[String:Int] = ["user_id": 1]
    var put_param:[String:Int] = [:]
    
    
    var flag = 0
    @IBOutlet weak var measureBtn: UIButton!
    
    @IBOutlet weak var lastcount: UILabel!
    @IBOutlet weak var nowcount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let lastdata = "3"
        lastcount.font = UIFont.systemFont(ofSize: 28)
        lastcount.text = "前回：" + lastdata + "回"
        lastcount.textAlignment = NSTextAlignment.center
        
        
        nowcount.font = UIFont.systemFont(ofSize: 35)
        nowcount.text = "計測待ち"
        nowcount.textAlignment = NSTextAlignment.center
        
        measureBtn.setTitle("開始", for: .normal)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func moveToDetail(_ sender: Any) {
        
        if flag == 0 {
            measureBtn.setImage(UIImage.init(named: "stop"), for: UIControlState.normal)
            nowcount.text = "計測中"
            self.timer = Timer.scheduledTimer(timeInterval: 1,                                         //ループなら間隔 1度きりなら発動までの秒数
                target: self,                                         //メソッドを持つオブジェクト
                selector: #selector(ViewController.timerUpdate),  //実行するメソッド
                userInfo: nil,                                        //オブジェクトに付けて送信する値
                repeats: true)
            
            let APIUrl = urlStr + "walk"
            
            //var request = URLRequest(url: URL(string: APIUrl)!)
            //request.httpMethod = "POST"
            Alamofire.request(APIUrl, method: .post, parameters: param, encoding: JSONEncoding(options: []))
                .responseJSON { response in
                    guard let object = response.result.value else {
                        return
                    }
                    
                    let json = JSON(object)
                    
                    
                    let article: [String: Int] = ["walk_id": json["walk_id"].intValue]
                    self.put_param = article
//                    print(self.put_param)
            }
            flag = 1
        } else {
            
            //"開始"をタップでアラート表示
            let alert: UIAlertController = UIAlertController(title: "本当に終了しますか？", message: "", preferredStyle:  UIAlertControllerStyle.alert)
            
            let saveBtn: UIAlertAction = UIAlertAction(title: "保存", style: UIAlertActionStyle.default, handler:{
                // ボタンが押された時の処理を書く（クロージャ実装）
                (action: UIAlertAction!) -> Void in
                print("OK")
                self.measureBtn.setImage(UIImage.init(named: "start"), for: UIControlState.normal)
                self.flag = 0
                
                print("UUUUUUUUUUUU")
                print(self.flag)
                
                self.timer?.invalidate()
                
                let APIUrl = self.urlStr + "walk"
                
                //var request = URLRequest(url: URL(string: APIUrl)!)
                //request.httpMethod = "GET"
                
                print("****************")
                print("*****HOHOHOHHOHOHOHOH********")
                
                Alamofire.request(APIUrl, method: .put, parameters: self.put_param, encoding: JSONEncoding(options: []))
                    .responseJSON { response in
                        
//                        print(response.result.value)
                        guard let object = response.result.value else {
                            return
                        }
                        
                        let json = JSON(object)
                        print(json)
                }
                
                let storyboard: UIStoryboard = UIStoryboard(name: "Detail", bundle: nil)
                let nextView = storyboard.instantiateInitialViewController()
                self.present(nextView!, animated: true, completion: nil)
            })
            
            let restartBtn = UIAlertAction(title: "再開", style: UIAlertActionStyle.cancel, handler:{
                // ボタンが押された時の処理を書く（クロージャ実装）
                (action: UIAlertAction!) -> Void in
                print("Cancel")
                
            })
            
            alert.addAction(saveBtn)
            alert.addAction(restartBtn)
            
            present(alert, animated: true, completion: nil)
            
        }
        
    }
    
    @objc func timerUpdate() {
        // print("update")
        let APIUrl = urlStr + "walk/now?user_id=1"
        
        //var request = URLRequest(url: URL(string: APIUrl)!)
        //request.httpMethod = "GET"
        
        Alamofire.request(APIUrl, method: .get, encoding: JSONEncoding(options: []))
            .responseJSON { response in
                
                guard let object = response.result.value else {
                    return
                }
                
                let json = JSON(object)
                print(json)
        }
    }
    
}

