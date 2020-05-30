//
//  ViewController.swift
//  SunriseApp
//
//  Created by 西岡亮太 on 2020/05/29.
//  Copyright © 2020 西岡亮太. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cityNameInput: UITextField!
    
    @IBOutlet weak var sunriseTimeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func findSunrise(_ sender: Any) {
        let url =
        "http://api.openweathermap.org/data/2.5/weather?q=\(cityNameInput.text!)&appid=a4a46dd938458cf1d8b831600910dfee"
        
        getURL(url: url)
        
    }
    
    func getURL(url:String){
        do{
            let apiURL = URL(string:url)!
            let data = try Data(contentsOf: apiURL)
            let json = try JSONSerialization.jsonObject(with: data) as! [String:Any]
            //print(json)
            let sys = json["sys"]as! [String:Any]
            let dateUnix: TimeInterval = sys["sunrise"]! as! TimeInterval
            let date = NSDate(timeIntervalSince1970: dateUnix)
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let dateStr: String = formatter.string(from: date as Date)
            //self.sunriseTimeLabel.text = "日の出時刻: \(sys["sunrise"]!)"
            self.sunriseTimeLabel.text = "日の出時刻: \(dateStr)"

        }catch{
            self.sunriseTimeLabel.text = "サーバーに接続できません"
        }
    }
    
}

