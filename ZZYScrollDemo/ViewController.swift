//
//  ViewController.swift
//  ZZYScrollDemo
//
//  Created by zzy on 2018/5/24.
//  Copyright © 2018年 zzy. All rights reserved.
//

import UIKit

class ViewController:BaseViewController  {

    override func viewDidLoad() {
        super.viewDidLoad()
        let btn:UIButton = UIButton.init(frame: CGRect.init(x: ScreenWidth / 2.0 - 50.0, y: 300.0, width: 100.0, height: 44.0))
        btn.backgroundColor = UIColor.red
        btn.setTitle("显示", for: UIControlState.normal)
        btn.setTitleColor(UIColor.white, for: UIControlState.normal)
        
        btn.addTarget(self, action: #selector(clickBtn), for: UIControlEvents.touchUpInside)
        self.view.addSubview(btn)
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    
    @objc func clickBtn(){
        
        self.navigationController?.pushViewController(ScrollTestViewController(), animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

