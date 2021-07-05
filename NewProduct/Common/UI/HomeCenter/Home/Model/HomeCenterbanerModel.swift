//
//  HomeCenterbanerModel.swift
//  NewProduct
//
//  Created by 狍子 on 2021/6/24.
//

import UIKit
import HandyJSON


class HomeCenterbanerModel: HandyJSON {
    var vrId: String = ""
    var title: String = ""
    var imgUrl:String?
    var url: String?
    var praise: String?
    var visit: String?
    var userId: String?
    var createTime: Int?
    var flag: String?
    var categoryId: String?
    var isPublic: String?

    required init(){} // 必须实现一个空的初始化方法

}
