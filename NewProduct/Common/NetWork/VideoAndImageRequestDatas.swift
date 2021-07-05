//
//  VideoAndImageRequestDatas.swift
//  NewProduct
//
//  Created by 狍子 on 2021/6/28.
//

import UIKit

class VideoAndImageRequestDatas: NSObject {
    // MARK: -  上传图片
    func RequestWithData(parameters:[String:String]?=nil,imageData: [String:Data],success:@escaping(_ result:Any)->(),failure:@escaping(_ fail:Any)->()) -> Void {
        let UrlPath = "http://111.74.0.246:8081/vrplatform/oss/object/v2-cloud"
        BaseRequestDatas().PostRequestWithUpload(pathurl: UrlPath, parameters: parameters, imageData: imageData, success: { (result) in
            var resultDic = [String: Any]()
            resultDic = result as! [String : Any]
            //            let status = resultDic["status"] as? Int
            guard let status = resultDic["code"] as? Int else {return}
            print(result)
            if status != 200 {
               
//                ErrorMessageTips().showTips(title: resultDic["error_desc"] as! String)
            }
            //            guard let data = resultDic["data"] as? [String : Any],
            //                let orderList = data["strokes"] as? [[String : Any]],
            //                let expressOrderList = Mapper<StrokelistModel>().mapArray(JSONObject: orderList) else {return}
            if status == 200 {
                guard let data = resultDic["data"] as? [String : Any] else {return}
                guard let objectContent = data["objectContent"]  as? [String : Any] else {return}
                guard let httpRequest = objectContent["httpRequest"]  as? [String : Any] else {return}
                
                let uri = httpRequest["uri"]  

                print("==================================")
                print(uri)
                success(uri)
                
            }
        }) { (error) in
            
        }
        
    }
}
