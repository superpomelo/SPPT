//
//  FileCenterModel.swift
//  NewProduct
//
//  Created by 狍子 on 2021/6/25.
//

import UIKit
import HandyJSON


class FileCenterModel: HandyJSON {
    var company: String = ""
    var cooperateType: String = ""
    var cooperationId:String?
    var createTime: String?
    var describe: String?
    var name: String?
    var status: NSInteger = 1
    var tel: String?
    var title: String?
    var userId: String?
    var vrType: String?
    var amount: String = "0.00"
    var completionTime: String?

    required init(){} // 必须实现一个空的初始化方法

}
