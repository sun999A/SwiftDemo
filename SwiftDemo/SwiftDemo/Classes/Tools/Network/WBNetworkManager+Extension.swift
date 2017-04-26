//
//  WBNetworkManager+Extension.swift
//  SwiftDemo
//
//  Created by feiyu iOS on 17/4/19.
//  Copyright © 2017年 Mwy Group. All rights reserved.
//

import Foundation
extension WBNetworkManager{
    func statusList( since_id: Int64 = 0, max_id: Int64 = 0,completion: @escaping (_ list: [[String : AnyObject]]?,_ isSuccess: Bool) ->()) {
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        //let params = ["access_token":"2.00U391uBJvjJ7B3a74ae7ebc0eH4s3"]
        let params = ["since_id": "\(since_id)", "max_id" : "\(max_id > 0 ? max_id - 1 : 0 )"]
        tokenRequest(URLString: urlString, parameters: params) { (json, isSuccess) in
          
           // print(json!)
              //let result = json?["statuses"] as? [[String: AnyObject]]
        let result = (json as! NSDictionary)["statuses"] as? [[String :AnyObject]]
            
//            let dict = json as? [String : AnyObject]
//            let result = dict?["status"]

            
            
            completion(result ?? nil, isSuccess)
           
            
            
        }

    }
    
    
    func unreadCount(completion:@escaping( _ count: Int) ->()){
        
        guard let uid = uid else {
            return
        }
        let urlString = "https://rm.api.weibo.com/2/remind/unread_count.json"
        let params = ["uid" : uid]
        
        tokenRequest(URLString: urlString, parameters: params) { (json, isSuccess) in
            
            let dict = json as? [String : AnyObject]
            let count = dict?["status"] as? Int
            completion(count ?? 0)
            
            
            
            //print(json!)
        }
        
    }
}



