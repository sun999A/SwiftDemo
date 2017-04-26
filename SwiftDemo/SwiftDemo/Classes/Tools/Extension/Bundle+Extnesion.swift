//
//  Bundle+Extnesion.swift
//  SwiftDemo
//
//  Created by feiyu iOS on 17/4/11.
//  Copyright © 2017年 Mwy Group. All rights reserved.
//

import Foundation

extension Bundle{
    var namespace:String{
        return infoDictionary?["CFBundleName"] as? String ?? ""
        
        
    }
}
