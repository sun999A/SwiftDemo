//
//  WBStatusListViewModel.swift
//  SwiftDemo
//
//  Created by feiyu iOS on 17/4/20.
//  Copyright © 2017年 Mwy Group. All rights reserved.
//

import Foundation
class WBStatusListViewModel {
    private let maxPullupTryTimes = 3
    
    lazy var statusList = [WBStatus]()
    
     private var maxPullupErrorTimes = 0
    
    func loadStatus(pullup: Bool,completion:  @escaping ( _ isSuccess:Bool, _ shouldRefresh:Bool) ->())  {
        if pullup && maxPullupErrorTimes > maxPullupTryTimes {
            completion(true, false)
            
            return
        }
        
        let since_id = pullup ? 0 : (statusList.first?.id ?? 0)
        let max_id =  !pullup ? 0 : (statusList.last?.id ?? 0)
        WBNetworkManager.shared.statusList(since_id: since_id, max_id: max_id) { (list, isSuccess) in
            guard let array = NSArray.yy_modelArray(with: WBStatus.self, json: list ?? []) as? [WBStatus] else{
                
            completion(isSuccess, false)
                return
            }
            print("刷新了\(array.count)数据")
            if pullup{
                //上拉
                self.statusList += array
            }else{
               //下拉
                self.statusList = array + self.statusList
                
            }
            
            if pullup && array.count == 0{
                self.maxPullupErrorTimes += 1
                 completion(isSuccess, false)
            }else{
                
                completion(isSuccess, true)
            }
            
            
            
            
        }
    }
}
