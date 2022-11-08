//
//  TopVC.swift
//  Marvel
//
//  Created by Aly Fawzy on 08/11/2022.
//

import UIKit

class TopVC: NSObject {
        
    class func view() -> UIView {
        
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first

        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            
            return topController.view
        }
        
        return keyWindow?.rootViewController?.view ?? UIView()
    }
    
    class func loadingToast(){
        DispatchQueue.main.async {
            view().makeToastActivity(.center)
        }
    }
    
    class func dismissToast(){
        DispatchQueue.main.async {
            view().hideToastActivity()
            view().clearToastQueue()
        }
    }
    
    class func removeAllToast(){
        DispatchQueue.main.async {
            view().hideAllToasts()
            view().clearToastQueue()
        }
    }
    
    class func showToast(_ message: String, position: ToastPosition){
        DispatchQueue.main.async {
            TopVC.view().makeToast(message, position: position)
        }
    }
    
}
