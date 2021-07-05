//
//  FenLeiRequestDatas.swift
//  NewProduct
//
//  Created by 狍子 on 2021/7/1.
//

import UIKit
import Alamofire
import HandyJSON

class FenLeiRequestDatas: NSObject {
    /**获取VR资源列表接口*/
    func RequestWithvrgetVrList(parameters:[String:String]?=nil,success:@escaping(_ result:[Any])->(),failure:@escaping(_ fail:Any)->()) -> Void {
        let PathUrl = Host + "vr/getVrList"
       
        BaseRequestDatas().RequestWithPathUrl(isToken:false,pathurl: PathUrl, parameters: parameters, httpMethod: "POST", encoding: JSONEncoding.default, headers: nil) { (result) in
            
            var resultDic = [String: Any]()
            resultDic = result as! [String : Any]
            print(result)
            let status = resultDic["code"] as? Int
            if status == 1 {
                let data = resultDic["data"]
        
                success(data as! [Any])
            }

        } failure: { (error) in
            
        }
    }
    
    
}
