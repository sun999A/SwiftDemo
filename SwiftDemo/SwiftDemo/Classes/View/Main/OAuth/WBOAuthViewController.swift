//
//  WBOAuthViewController.swift
//  SwiftDemo
//
//  Created by feiyu iOS on 17/4/24.
//  Copyright © 2017年 Mwy Group. All rights reserved.
//

import UIKit

class WBOAuthViewController: UIViewController {
    
    private lazy var webView = UIWebView()
    override func loadView() {
        view = webView
        view.backgroundColor = UIColor.white
        title = "登录新浪微博"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", target: self, action: #selector(close), isBack:true)
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc fileprivate func close(){
        dismiss(animated: true, completion: nil)
        
        
    }

   
}
