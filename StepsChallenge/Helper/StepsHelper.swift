//
//  StepsHelper.swift
//  StepsChallenge
//
//  Created by dreams on 1/9/19.
//  Copyright © 2019 Steps. All rights reserved.
//

import UIKit
import MBProgressHUD

class StepsHelper: NSObject {
    
    var progressHud = MBProgressHUD()

    //structor
    class var shared : StepsHelper {
        struct Static {
            static let instance = StepsHelper()
        }
        
        return Static.instance
    }
    
    // show the alert view
    func showAlertViewWithTitle(_ title:String?, message:String, buttonTitles:[String], viewController:UIViewController, completion: ((_ index: Int) -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for buttonTitle in buttonTitles {
            let alertAction = UIAlertAction(title: buttonTitle, style: .default, handler: { (action:UIAlertAction) in
                completion?(buttonTitles.index(of: buttonTitle)!)
            })
            alertController .addAction(alertAction)
        }
        viewController .present(alertController, animated: true, completion: nil)
    }
    
    // show MB Progress Hud
    func startLoader(view:UIView){
        progressHud = MBProgressHUD.showAdded(to: view, animated: true)
        progressHud.bezelView.color = UIColor(red: (255.0/255.0), green: (255.0/255.0), blue: (255.0/255.0), alpha: 0.8)
        progressHud .show(animated: true)
    }
    
    // hide MB Progress Hud
    func stopLoader() {
        progressHud .hide(animated: true)
    }
    
}
