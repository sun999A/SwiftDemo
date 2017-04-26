//
//  WBStatus.swift
//  SwiftDemo
//
//  Created by feiyu iOS on 17/4/20.
//  Copyright © 2017年 Mwy Group. All rights reserved.
//

import UIKit
import YYModel
class WBStatus: NSObject {
    
    var id: Int64 = 0
    var text: String?
    
    override var description: String{
       return yy_modelDescription()
    }

}
