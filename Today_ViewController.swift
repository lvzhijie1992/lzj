//
//  Today_ViewController.swift
//  Today
//
//  Created by 吕志杰 on 2017/6/30.
//  Copyright © 2017年 lvzhijie. All rights reserved.
//

import UIKit

class Today_ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var tableview : UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "首页"
        tableview = UITableView(frame:CGRect(x:0,y:0,width:self.view.frame.size.width,height:self.view.frame.size.height))
        tableview?.delegate = self
        tableview?.dataSource = self
        tableview?.register(UITableViewCell().classForCoder, forCellReuseIdentifier: "cell")
        self.view .addSubview(tableview!)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview?.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell?.textLabel?.text = "我是首页"
        return cell!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
