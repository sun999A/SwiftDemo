//
//  WBHomeViewController.swift
//  SwiftDemo
//
//  Created by feiyu iOS on 17/4/11.
//  Copyright © 2017年 Mwy Group. All rights reserved.
//
//https://api.weibo.com/2/statuses/home_timeline.json?access_token=2.00U391uBJvjJ7B3a74ae7ebc0eH4s3
import UIKit

private let cellId = "cellId"
class WBHomeViewController: WBBaseViewController {

   fileprivate lazy var listViewModel = WBStatusListViewModel()
    //fileprivate lazy var statusList = [String]()
    override func loadData() {
        
//        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
//        let params = ["access_token":"2.00U391uBJvjJ7B3a74ae7ebc0eH4s3"]
        
//        WBNetworkManager.shared.get(urlString, parameters: params, progress: nil, success: { (_, json) in
//            print(json as Any)
//        }) { (_, error) in
//            print("失败\(error)")
//            
//            
//        }
        
//        WBNetworkManager.shared.request(URLString: urlString, parameters: params) { (json, isSuccess) in
//            print(json!)
//        }
        
        
//        WBNetworkManager.shared.statusList { (list, isSucces) in
//            
//          print(list!)
//        
//            
//        }
        
        listViewModel.loadStatus (pullup:  self.isPullup){ (isSuccess, hasMorePullup) in
            self.refreshControl?.endRefreshing()
            self.isPullup = false
            if hasMorePullup{
                self.tableView?.reloadData()
                
            }
            
            
        }
        
        
        
       // print("加载数据\(WBNetworkManager.shared)")
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
//            
//            for i in 0..<20 {
//                
//                if self.isPullup {
//                    
//                    //底部
//                    self.statusList.append("上拉\(i)")
//                }else{
//                    //顶部
//                    self.statusList.insert(i.description, at: 0)
//                }
//                
//            }
//            self.refreshControl?.endRefreshing()
//            self.isPullup = false
//            self.tableView?.reloadData()
//        }
    }
    
 @objc fileprivate func showFriends(){
    let vc = WBDemoViewController()
    //vc.hidesBottomBarWhenPushed = true
    navigationController?.pushViewController(vc, animated: true)
    
    
    }

   
}

extension WBHomeViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.statusList.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = listViewModel.statusList[indexPath.row].text
        return cell
    }
}
extension WBHomeViewController{
    
    override func setupTableView() {
        super.setupTableView()
    
        
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "好友", style: .plain, target: self, action: #selector(showFriends))
        
//        let btn: UIButton = UIButton.cz_textButton("好友", fontSize: 16, normalColor: UIColor.darkGray, highlightedColor: UIColor.orange)
//        btn.addTarget(self, action: #selector(showFriends), for: .touchUpInside)
//        
//        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        
        
        navItem.leftBarButtonItem = UIBarButtonItem(title: "好友", target: self, action: #selector(showFriends))
        
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        
        
        
    }
}
