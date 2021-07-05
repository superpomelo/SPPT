//
//  FileRequestDatas.swift
//  NewProduct
//
//  Created by 狍子 on 2021/6/25.
//

import UIKit
import Alamofire
import HandyJSON
class FileRequestDatas: NSObject {
    /**获取申请合作列表接口*/
    func RequestWithgetCooperationList(parameters:[String:String]?=nil,success:@escaping(_ result:[Any])->(),failure:@escaping(_ fail:Any)->()) -> Void {
        let PathUrl = Host + "cooperation/getCooperationList"
       
        BaseRequestDatas().RequestWithPathUrl(isToken:false,pathurl: PathUrl, parameters: parameters, httpMethod: "POST", encoding: JSONEncoding.default, headers: nil) { (result) in
            
            var resultDic = [String: Any]()
            resultDic = result as! [String : Any]
            print(result)
            let status = resultDic["code"] as? Int
            if status == 1 {
                let data = resultDic["data"] as! [Any]
                

                
                
                success(data as [Any])
            }

        } failure: { (error) in
            
        }
    }
    /**上传合作申请接口*/
    func RequestWithaddCooperation(parameters:[String:String]?=nil,success:@escaping(_ result:[String : Any])->(),failure:@escaping(_ fail:Any)->()) -> Void {
        let PathUrl = Host + "cooperation/addCooperation"
       
        BaseRequestDatas().RequestWithPathUrl(isToken:false,pathurl: PathUrl, parameters: parameters, httpMethod: "POST", encoding: JSONEncoding.default, headers: nil) { (result) in
            
            var resultDic = [String: Any]()
            resultDic = result as! [String : Any]
            print(result)
            let status = resultDic["code"] as? Int
            if status == 1 {
//                let data = resultDic["data"] as! [String : Any]
                

                
                
                success(resultDic)
            }else{
                failure("error")

            }

        } failure: { (error) in
            failure(error)
        }
    }
    
}
