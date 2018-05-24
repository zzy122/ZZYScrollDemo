//
//  ConfigFile.swift
//  ZZYScrollDemo
//
//  Created by zzy on 2018/5/24.
//  Copyright © 2018年 zzy. All rights reserved.
//

import Foundation
import UIKit

let ScreenHeight = UIScreen.main.bounds.height

let ScreenWidth = UIScreen.main.bounds.width

func DebugLog<T>(message:T){
    #if DEBUG
        print("\(message)")
    #endif
}

