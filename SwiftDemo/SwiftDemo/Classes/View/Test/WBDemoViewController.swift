//
//  WBDemoViewController.swift
//  SwiftDemo
//
//  Created by feiyu iOS on 17/4/12.
//  Copyright © 2017年 Mwy Group. All rights reserved.
//

import UIKit

class WBDemoViewController: WBBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "第\(navigationController?.childViewControllers.count ?? 0)个"
    }
    
    @objc fileprivate func showNext(){
        let vc = WBDemoViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

   
}

extension WBDemoViewController{
    
    
    override func setupTableView() {
        super.setupTableView()
        let btn: UIButton = UIButton.cz_textButton("下一个", fontSize: 16, normalColor: UIColor.darkGray, highlightedColor: UIColor.orange)
        btn.addTarget(self, action: #selector(showNext), for: .touchUpInside)
        
        navItem.rightBarButtonItem  = UIBarButtonItem(customView: btn)
    }
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "下一个", style: .plain, target: self, action: #selector(showNext))

}
