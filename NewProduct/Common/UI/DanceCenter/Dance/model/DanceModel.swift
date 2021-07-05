//
//  DanceModel.swift
//  NewProduct
//
//  Created by 狍子 on 2021/7/1.
//

import UIKit
import HandyJSON

class DanceModel: HandyJSON {
    var videoId: NSInteger = 0
    var title: String = ""
    var imgUrl:String = ""
    var url: String = ""
    var praise: NSInteger = 0
    var visit: NSInteger = 0
    var createTime: String = ""
    var flag: NSInteger = 0
    var categoryId: NSInteger = 0
    var isPublic: NSInteger = 0


    required init(){} // 必须实现一个空的初始化方法
}
