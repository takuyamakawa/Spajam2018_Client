//
//  ViewController.swift
//  spajam2018
//
//  Created by 山川拓也 on 2018/05/08.
//  Copyright © 2018年 山川拓也. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var flag = 0
    @IBOutlet weak var measureBtn: UIButton!
    
    @IBOutlet weak var lastcount: UILabel!
    @IBOutlet weak var nowcount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let lastdata = "13"
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
            
            flag = 1
        } else {
            
            //"開始"をタップでアラート表示
            let alert: UIAlertController = UIAlertController(title: "結果はx回でした", message: "本当に終了しますか？", preferredStyle:  UIAlertControllerStyle.alert)
            
            let saveBtn: UIAlertAction = UIAlertAction(title: "保存", style: UIAlertActionStyle.default, handler:{
                // ボタンが押された時の処理を書く（クロージャ実装）
                (action: UIAlertAction!) -> Void in
                print("OK")
                self.measureBtn.setImage(UIImage.init(named: "start"), for: UIControlState.normal)
                self.flag = 0
                
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
    
}

