//
//  SwitchRootController.swift
//  Dzbz
//
//  Created by 狍子 on 2021/3/16.
//

import UIKit

class SwitchRootController: NSObject {
   
    public func goHomeViewController() -> Void {
    UIApplication.shared.windows[0].rootViewController = TabBarViewController()
    UIApplication.shared.windows[0].makeKeyAndVisible()
    }
    
    public func goLoginController() -> Void {
        UserInfoManager.removeAllValue()
        UIApplication.shared.windows[0].rootViewController = UINavigationController.init(rootViewController: PassWordViewController()) 
        UIApplication.shared.windows[0].makeKeyAndVisible()
     }
    
//    public func goHomeController() -> Void {
//        UIApplication.shared.windows[0].rootViewController = UINavigationController.init(rootViewController: HomeCenterViewController())
//        UIApplication.shared.windows[0].makeKeyAndVisible()
//     }
}
