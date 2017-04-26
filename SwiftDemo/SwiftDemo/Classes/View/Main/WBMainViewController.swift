//
//  WBMainViewController.swift
//  SwiftDemo
//
//  Created by feiyu iOS on 17/4/11.
//  Copyright © 2017年 Mwy Group. All rights reserved.
//
//App Key：1302639043
//App Secret：ec2f1bb9d543517135de7babb684c88f
//http://baidu.com/?code=ec2f1bb9d543517135de7babb684c88f

//https://api.weibo.com/oauth2/authorize?client_id=1302639043&redirect_uri=http://baidu.com


import UIKit

class WBMainViewController: UITabBarController {
    
    fileprivate var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupChildControllers()
        setupComposeButton()
        setupTimer()
        
        delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(userLogin), name: NSNotification.Name(rawValue: WBUserShouldLoginNotification), object: nil)
        
//        
//        WBNetworkManager.shared.unreadCount { (count) in
//            
//        }
        
        
        // Do any additional setup after loading the view.
    }
    
    deinit {
        timer?.invalidate()
        NotificationCenter.default.removeObserver(self)
        
        
    }
    
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .portrait
    }
    
    @objc private func userLogin(n: Notification){
        print("用户登录\(n)")
        let nav = UINavigationController(rootViewController:WBOAuthViewController())
        
        
        present(nav, animated: true, completion: nil)
        
        
        
    }
    
    
    @objc fileprivate func composeStatus(){
        print("1111")
        let vc = UIViewController()
        let nav = UINavigationController(rootViewController: vc)
        vc.view.backgroundColor = UIColor.cz_random()
        present(nav, animated: true, completion: nil)
        
        
        
        
    }
    
     lazy var composeButton: UIButton = UIButton.cz_imageButton("tab_cartselect", backgroundImageName: "")
    
    
    

   
}

extension WBMainViewController: UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
      let idx = (childViewControllers as NSArray).index(of: viewController)
        
        if selectedIndex == 0 && idx == selectedIndex {
            print("首页")
            
            let nav = childViewControllers[0] as! UINavigationController
            let vc = nav.childViewControllers[0] as! WBHomeViewController
            
            vc.tableView?.setContentOffset(CGPoint(x: 0, y: -64), animated: true)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                vc.loadData()
            })
            //vc.tableView?.reloadData()
        }
        
        
        return  !viewController.isMember(of: UIViewController.self)
    }
}

extension WBMainViewController{
    fileprivate func setupTimer(){
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTimer(){
        //print(#function)
        WBNetworkManager.shared.unreadCount { (count) in
            print("---------\(count)")
            self.tabBar.items?[0].badgeValue = count > 0 ? "\(count)" : nil
            
            UIApplication.shared.applicationIconBadgeNumber = count
            
            
        }
    }
}

extension WBMainViewController{
    
    fileprivate func setupComposeButton(){
        tabBar.addSubview(composeButton)
        
        let count = CGFloat(childViewControllers.count)
        let w = tabBar.bounds.width / count
        
        composeButton.frame = tabBar.bounds.insetBy(dx: 2*w, dy: 0)
        
        composeButton.addTarget(self, action: #selector(composeStatus), for: .touchUpInside)
        
        
    }
   fileprivate func setupChildControllers(){
    
    let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    let jsonPath = (docDir as NSString).appendingPathComponent("demo.json")
    
    var data = NSData(contentsOfFile: jsonPath)
    if data == nil{
        let path = Bundle.main.path(forResource: "demo.json", ofType: nil)
        data = NSData(contentsOfFile: path!)
    }
    
    
    
   guard let array = try? JSONSerialization.jsonObject(with: data! as Data, options: []) as? [[String : AnyObject]]
    else{
        return
    }
    
 
    
//    let array: [[String : Any]] = [
//            ["clsName":"WBHomeViewController" , "title":"首页", "imageName":"home","visitorInfo":["imageName":"", "message":"关注一些人,看看惊喜"]
//        ],
//             ["clsName":"WBMessageViewController", "title":"消息", "imageName":"group","visitorInfo":["imageName":"visitordiscover_image_message", "message":"登陆后,别人评论的微博,发你信息,收到通知"]],
//             ["clsName":"UIViewController"],
//              ["clsName":"WBDiscoverViewController", "title":"发现", "imageName":"super","visitorInfo":["imageName":"visitordiscover_image_message", "message":"登陆后,最新最热微博尽在掌握,不会与事实擦肩而过"]],
//               ["clsName":"WBProfileViewController", "title":"我", "imageName":"mine","visitorInfo":["imageName":"visitordiscover_image_profile", "message":"登陆后,你的微博.相册.个人资料显示在这里,展示给别人"]],
//            
//        ]
//        
////        (array as NSArray).write(toFile: "/Users/mc/Desktop/demo.plist", atomically: true)
//    let data = try! JSONSerialization.data(withJSONObject: array, options: [.prettyPrinted])
//    //let fileURL = NSURL.fileURL(withPath: "/Users/mc/Desktop/demo.plist")
//    (data as NSData).write(toFile: "/Users/mc/Desktop/demo.json", atomically: true)

    
    
    
    
        var arrayM = [UIViewController]()
        for dict in array!{
            arrayM.append(controller(dict: dict))
            
        }
        
        viewControllers = arrayM
        
    }
    
    
    private func controller(dict:[String: Any]) ->UIViewController{
        guard let claName = dict["clsName"] as? String,
        let title = dict["title"]  as? String,
        let imageName = dict["imageName"]  as? String,
        let cls = NSClassFromString(Bundle.main.namespace + "." + claName) as? WBBaseViewController.Type,
        let visitorDict = dict["visitorInfo"]  as? [String : String]
            
            
            else {
            return UIViewController()
            
            
        }
        
        let vc = cls.init()
        vc.title = title
        
        vc.visitorInfoDic = visitorDict
        
        vc.tabBarItem.image = UIImage(named:"tab_" + imageName)
        vc.tabBarItem.selectedImage = UIImage(named:"tab_" + imageName + "select")?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.red], for: .highlighted)
        //系统默认12
       vc.tabBarItem.setTitleTextAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: 12)], for: UIControlState(rawValue:0))
        
        
        let nav = WBNavigationViewController(rootViewController:vc)
        
        return nav
        
        
        
    }
}
