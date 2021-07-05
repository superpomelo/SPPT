//
//  passWordLoginModel.swift
//  Dzbz
//
//  Created by 狍子 on 2021/3/18.
//

import UIKit
import HandyJSON

class passWordLoginModel: HandyJSON {
    var birthday: String = ""
    var createTime: String = ""
    var userId:Int?
    var name: String?
    var tel: String?
    var realName: String?
    var nickName: Int?
    var userName: String?
    var avatar: String?

    required init(){} // 必须实现一个空的初始化方法
}
