//
//  UIBarButtonItem+Extension.swift
//  SwiftDemo
//
//  Created by feiyu iOS on 17/4/12.
//  Copyright © 2017年 Mwy Group. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    convenience init(title:String, fontSize:CGFloat = 16, target:AnyObject?,action:Selector, isBack:Bool = false) {
        let btn: UIButton = UIButton.cz_textButton(title, fontSize: fontSize, normalColor: UIColor.darkGray, highlightedColor: UIColor.orange)
        btn.addTarget(target, action: action, for: .touchUpInside)
        
        self.init(customView:btn)
        
        if isBack{
            let imageName = "fback"
            btn.setImage(UIImage(named:imageName), for: UIControlState(rawValue:0))
            btn.setImage(UIImage(named:"top_left"), for: .highlighted)
            btn.sizeToFit()
        }
        
        

    }
}
