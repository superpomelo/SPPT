//
//  HomeRequestDatas.swift
//  NewProduct
//
//  Created by 狍子 on 2021/6/24.
//

import UIKit
import Alamofire
import HandyJSON

class HomeRequestDatas: NSObject {
    /**获取推荐VR资源列表接口*/
    func RequestWithgetHome(parameters:[String:String]?=nil,success:@escaping(_ result:[String : Any])->(),failure:@escaping(_ fail:Any)->()) -> Void {
        let PathUrl = Host + "home/getHome"
       
        BaseRequestDatas().RequestWithPathUrl(isToken:false,pathurl: PathUrl, parameters: parameters, httpMethod: "POST", encoding: JSONEncoding.default, headers: nil) { (result) in
            
            var resultDic = [String: Any]()
            resultDic = result as! [String : Any]
            print(result)
            let status = resultDic["code"] as? Int
            if status == 1 {
                let data = resultDic["data"] as! [String : Any]
                

                
                
                success(data as [String : Any])
            }

        } failure: { (error) in
            
        }
    }
    
}
