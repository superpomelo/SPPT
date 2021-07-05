//
//  PersonalRequestData.swift
//  Dzbz
//
//  Created by 狍子 on 2021/3/18.
//

import UIKit
import Alamofire
import HandyJSON

class PersonalRequestData: NSObject {
    
    /**修改个人信息*/
    func RequestWithedituser(parameters:[String:String]?=nil,success:@escaping(_ result:Any)->(),failure:@escaping(_ fail:Any)->()) -> Void {
        let PathUrl = Host + "user/edituser"
       
        BaseRequestDatas().RequestWithPathUrl(isToken:true,pathurl: PathUrl, parameters: parameters, httpMethod: "POST", encoding: JSONEncoding.default, headers: nil) { (result) in
            
            var resultDic = [String: Any]()
            resultDic = result as! [String : Any]
            print(result)
            let status = resultDic["code"] as? Int
            if status == 1 {
//                let model = PersonCenterModel.deserialize(from: resultDic["data"] as? NSDictionary)

                
                success("model" as Any)
            }else{
                failure("")
            }

        } failure: { (error) in
            failure("")

        }
    }

    
    /**获取个人信息*/
    
    func RequestWithuserinfo(parameters:[String:String]?=nil,success:@escaping(_ result:Any)->(),failure:@escaping(_ fail:Any)->()) -> Void {
        let PathUrl = Host + "user/info"
       
        BaseRequestDatas().RequestWithPathUrl(isToken:true,pathurl: PathUrl, parameters: parameters, httpMethod: "POST", encoding: JSONEncoding.default, headers: nil) { (result) in
            
            var resultDic = [String: Any]()
            resultDic = result as! [String : Any]
            print(result)
            let status = resultDic["code"] as? Int
            if status == 1 {
            let model = PersonCenterModel.deserialize(from: resultDic["data"] as? NSDictionary)

                
                success(model as Any)
            }else{
                failure("")
            }

        } failure: { (error) in
            failure("")

        }
    }
    
    /**修改密码*/
    
    func RequestWithusereditpwd(parameters:[String:String]?=nil,success:@escaping(_ result:Any)->(),failure:@escaping(_ fail:Any)->()) -> Void {
        let PathUrl = Host + "user/editpwd"
       
        BaseRequestDatas().RequestWithPathUrl(isToken:true,pathurl: PathUrl, parameters: parameters, httpMethod: "POST", encoding: JSONEncoding.default, headers: nil) { (result) in
            
            var resultDic = [String: Any]()
            resultDic = result as! [String : Any]
            print(result)
            let status = resultDic["code"] as? Int
            if status == 1 {
           

                
                success("model" as Any)
            }else{
                failure("")
            }

        } failure: { (error) in
            failure("")

        }
    }
    /**提交意见建议接口*/
    func RequestWithaddAdvis(parameters:[String:String]?=nil,success:@escaping(_ result:[String : Any])->(),failure:@escaping(_ fail:Any)->()) -> Void {
        let PathUrl = Host + "system/addAdvis"
       
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
    
    
    /**添加VR资源接口*/
    func RequestWithuseraddVr(parameters:[String:String]?=nil,success:@escaping(_ result:[String : Any])->(),failure:@escaping(_ fail:Any)->()) -> Void {
        let PathUrl = Host + "vr/addVr"
       
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
