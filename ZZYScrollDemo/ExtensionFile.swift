//
//  ExtensionFile.swift
//  test
//
//  Created by zzy on 2018/5/23.
//  Copyright © 2018年 zzy. All rights reserved.
//

import Foundation
import UIKit

extension String
{
    func caculateWidth(font:UIFont) -> CGFloat {
       
        let str = self as NSString
        let rect = str.boundingRect(with: CGSize.init(width: CGFloat(MAXFLOAT), height: 30), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName:font], context: nil)
        
        return ceil(rect.width)
    }
}


