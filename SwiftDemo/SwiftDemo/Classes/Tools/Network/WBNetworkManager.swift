//
//  WBNetworkManager.swift
//  SwiftDemo
//
//  Created by feiyu iOS on 17/4/19.
//  Copyright © 2017年 Mwy Group. All rights reserved.
//

import UIKit
import AFNetworking

enum WBHTTPMethod {
    case GET
    case POST

}
class WBNetworkManager: AFHTTPSessionManager {
    
    //单例
    static let shared = WBNetworkManager()
    
    var accessToken:String? //= "2.00U391uBJvjJ7B3a74ae7ebc0eH4s3"
    var uid:String? = "5365823342"
    var userLogon: Bool{
        return accessToken != nil
    }
    
    func tokenRequest(method:WBHTTPMethod = .GET,URLString: String, parameters:[String : Any?], completion: @escaping (_ json: Any?, _ isSuccess:Bool) ->()){
        
        guard let token = accessToken else {
            print("没有token需要登录")
            completion(nil, false)
            return
        }
        
        var parameters = parameters
        if parameters == nil {
            parameters = [String : Any]()
        }
        
        parameters["access_token"] = token as Any?
        
        request(URLString: URLString, parameters: parameters, completion: completion)
        
    }
    
    
    func request(method:WBHTTPMethod = .GET,URLString: String, parameters:[String : Any?], completion: @escaping (_ json: Any?, _ isSuccess:Bool) ->()){
        
        let success = {(task: URLSessionDataTask, json: Any?)->() in
            completion(json, true)
        }
        
        let failure = {(task: URLSessionDataTask?, error: Error)->() in
            
            if (task?.response as? HTTPURLResponse)?.statusCode == 403 {
                print("过期了")
            }
             print("失败\(error)")
            completion(nil, false)
        }
        
        if method == .GET {
            get(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
            
            
        }else{
            post(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
            
        }
        
    }

}
