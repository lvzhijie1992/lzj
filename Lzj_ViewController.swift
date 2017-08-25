//
//  Lzj_ViewController.swift
//  Today
//
//  Created by 憧憬云天888 on 2017/6/23.
//  Copyright © 2017年 lvzhijie. All rights reserved.
//

import UIKit
import Alamofire
import CoreMotion
public var str:Bool?
protocol zj {
        var name: String { get set }
    func wb()
}
class Lzj_ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var main_image: UIImageView!
    var main_tableview: UITableView!
    var name: String!
    var arr:NSMutableArray!
    var str:String!
    var age: Int!
    var textView: UITextView!
    let pedometer = CMPedometer()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "wod"
        arr = NSMutableArray()
        self.view.backgroundColor = UIColor.white
        main_image = UIImageView.init();
        main_image.frame = CGRect(x:100,y:100,width:100,height:100);
        main_image.image = UIImage(named:"头像")
        self.view.addSubview(main_image)
       // main_tableview = UITableView.init()
        main_tableview = UITableView(frame:CGRect(x:0,y:120,width:self.view.frame.size.width,height:self.view.frame.size.height-100-24), style:.grouped)
        main_tableview.delegate = self
        main_tableview.dataSource = self
        self.view.addSubview(main_tableview)
        main_tableview.register(UINib.init(nibName: "lzj_TableViewCell", bundle: nil), forCellReuseIdentifier: "maincell")
        main_tableview.rowHeight = UITableViewAutomaticDimension
        main_tableview.estimatedRowHeight = 44
        today()
        let ll = lv(name:"lzj")
        print(ll)
        print(zj.self)
        //startPedometerUpdates()
        var fullName:String
        {
            get
            {
                let timer :String! = "2"
                return timer
            }
        }
        print("今天放假喽",fullName)

    }

    
    struct lv{
        var title_l :String!
        init(name:String) {
            self.title_l = name
            print("我的名字：",self.title_l)
        }
    }
    
    func startPedometerUpdates() {
        //判断设备支持情况
        guard CMPedometer.isStepCountingAvailable() else {
            self.textView.text = "\n当前设备不支持获取步数\n"
            return
        }
        
        //获取今天凌晨时间
        let cal = Calendar.current
        var comps = cal.dateComponents([.year, .month, .day], from: Date())
        comps.hour = 0
        comps.minute = 0
        comps.second = 0
        let midnightOfToday = cal.date(from: comps)!
        
        //初始化并开始实时获取数据
        self.pedometer.startUpdates (from: midnightOfToday, withHandler: { pedometerData, error in
            //错误处理
            guard error == nil else {
                print(error!)
                return
            }
            
            //获取各个数据
            var text = "---今日运动数据---\n"
            if let numberOfSteps = pedometerData?.numberOfSteps {
                text += "步数: \(numberOfSteps)\n"
            }
            if let distance = pedometerData?.distance {
                text += "距离: \(distance)\n"
            }
            if let floorsAscended = pedometerData?.floorsAscended {
                text += "上楼: \(floorsAscended)\n"
            }
            if let floorsDescended = pedometerData?.floorsDescended {
                text += "下楼: \(floorsDescended)\n"
            }
            if let currentPace = pedometerData?.currentPace {
                text += "速度: \(currentPace)m/s\n"
            }
            if let currentCadence = pedometerData?.currentCadence {
                text += "速度: \(currentCadence)步/秒\n"
            }
            
            //在线程中更新文本框数据
            DispatchQueue.main.async{
               // self.textView.text = text
                 print("计算步数：",text)
            }
        })
    }
    
    func today() {
        var dic :NSDictionary!
        Alamofire.request("http://ksmgjb.vxiaoxiao.com//home/news/getList?_ajax=1&catId=12", method: .post).responseJSON {
            response in
            let JSON :NSDictionary! = response.result.value as! NSDictionary
            switch response.result{
            case .success(let success):
                  print("我的",JSON["data"] as! NSDictionary)
                  let da = JSON["data"] as! NSDictionary
                  let ro = da["Rows"] as! NSArray
                  for dict in ro
                  {
                    dic = dict as! NSDictionary
                   let model = Lzj_Model()
                    model.title_model = dic["articleContent"] as! String
                    print("我很好",dic["articleContent"] as! String)
                    let dictinoary:[String:String] = ["lzj":model.title_model]
                    self.arr.add(dictinoary)
                  }
                  print("我是数组",self.arr)
                  print("大家好",ro)
                print("JSON: \(success)")
                self.main_tableview.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 60
//    }
//    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : lzj_TableViewCell!
        cell = tableView.dequeueReusableCell(withIdentifier: "maincell", for: indexPath) as! lzj_TableViewCell

        let dict: NSDictionary! = self.arr[indexPath.row] as? NSDictionary
        cell.title_lab?.text = dict["lzj"] as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("success", (indexPath.row))
        self.navigationController?.pushViewController(Today_ViewController(), animated:true)
//        let ss = zj.wb(<#zj#>)
//        print(ss)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
