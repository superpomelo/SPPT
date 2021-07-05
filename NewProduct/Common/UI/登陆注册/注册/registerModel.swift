//
//  registerModel.swift
//  Dzbz
//
//  Created by 狍子 on 2021/3/18.
//

import UIKit
import HandyJSON

class registerModel: HandyJSON {
    var birthday: String = ""
    var createTime: String = ""
    var avatar:String?
    var nickname: String?
    var realname: String?
    var address: String?
    var tel: String?
    var userId: Int?
    var userName: String?

    required init(){} // 必须实现一个空的初始化方法

}
