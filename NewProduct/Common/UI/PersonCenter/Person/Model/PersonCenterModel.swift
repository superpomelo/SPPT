//
//  PersonCenterModel.swift
//  NewProduct
//
//  Created by 狍子 on 2021/6/30.
//

import UIKit
import HandyJSON

class PersonCenterModel: HandyJSON {
    var userName: String = ""
    var realName: String = ""
    var nickname:String = ""
    var gender: Int = 1
    var avatar: String = ""
    var address: String = ""
    var tel: String = ""
    var birthday: String = ""
    

    required init(){} // 必须实现一个空的初始化方法
}
