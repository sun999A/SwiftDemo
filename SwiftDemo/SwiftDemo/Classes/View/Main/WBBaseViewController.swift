//
//  WBBaseViewController.swift
//  SwiftDemo
//
//  Created by feiyu iOS on 17/4/11.
//  Copyright © 2017年 Mwy Group. All rights reserved.
//
//2.00U391uBJvjJ7B3a74ae7ebc0eH4s3
//https://api.weibo.com/2/statuses/home_timeline.json?access_token=2.00U391uBJvjJ7B3a74ae7ebc0eH4s3
import UIKit

class WBBaseViewController: UIViewController{
    
    //var userLogin = true
    
    var visitorInfoDic: [String : String]?
    
    
    var tableView: UITableView?
    var refreshControl:UIRefreshControl?
    var isPullup = false
    
    lazy var navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.cz_screenWidth(), height: 64))
    
    lazy var navItem = UINavigationItem()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
       
        
        WBNetworkManager.shared.userLogon ? loadData() : ()

        // Do any additional setup after loading the view.
    }
    
    
    
    override var title: String?{
        didSet{
            navItem.title = title
        }
    }
    
    func loadData(){
        self.refreshControl?.endRefreshing()
    }
    

   
}

extension WBBaseViewController{
    @objc fileprivate func login(){
        print("登录")
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: WBUserShouldLoginNotification), object: nil)
        
        
    }
    @objc fileprivate func register(){
        print("注册")
    }

}

extension WBBaseViewController{
  fileprivate  func setupUI(){
        
        
        view.backgroundColor = UIColor.white
        
        automaticallyAdjustsScrollViewInsets = false
        
        
        setupNavigationBar()
        setupTableView()
        
        WBNetworkManager.shared.userLogon ? setupTableView() : setupVisitorView()
        
        
        
        
        
    }
    
     func setupTableView(){
        tableView = UITableView(frame: view.bounds, style: .plain)
        view.insertSubview(tableView!, belowSubview:navigationBar)
        tableView?.dataSource = self
        tableView?.delegate = self
        
        tableView?.contentInset = UIEdgeInsetsMake(navigationBar.bounds.height, 0, tabBarController?.tabBar.bounds.height ?? 49, 0)
        
        refreshControl = UIRefreshControl()
        
        tableView?.addSubview(refreshControl!)
        refreshControl?.addTarget(self, action: #selector(loadData), for: .valueChanged)
        
        
    }
    
    private func setupVisitorView(){
        let visitorView = WBVisitorView(frame: view.bounds)
        
        view.insertSubview(visitorView, belowSubview: navigationBar)
        
        visitorView.visitorInfo = visitorInfoDic
        
        visitorView.loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        
         visitorView.registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)
        
        navItem.leftBarButtonItem = UIBarButtonItem(title: "注册", target: self, action: #selector(register))
        
        navItem.rightBarButtonItem = UIBarButtonItem(title: "登录", target: self, action: #selector(login))
        
        
        
        
        
    }
    
    
    private func setupNavigationBar(){
        view.addSubview(navigationBar)
        
        navigationBar.items = [navItem]
        
        navigationBar.barTintColor = UIColor.cz_color(withHex: 0xf6f6f6)
        
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.darkGray]
        
        navigationBar.tintColor = UIColor.orange
        

    }
}

extension WBBaseViewController:UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
        
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row = indexPath.row
        
        let section = tableView.numberOfSections - 1
        
        if row < 0 || section < 0{
            return
        }
        
        let count = tableView.numberOfRows(inSection: section)
        if row == (count - 1) && !isPullup{
            isPullup = true
            loadData()
        }
        
    }
}
