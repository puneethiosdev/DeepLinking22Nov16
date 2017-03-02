//
//  RemoteNotificationDeepLink.swift
//  Deeplink22Nov16
//
//  Created by Puneeth Kumar  on 22/11/16.
//  Copyright © 2016 ASM Technologies Limited. All rights reserved.
//

import UIKit

let RemoteNotificationDeepLinkAppSectionKey : String = "article"

class RemoteNotificationDeepLink: NSObject {
    
    var article : String = ""
    
    class func create(_ userInfo : [AnyHashable: Any]) -> RemoteNotificationDeepLink?
    {
        let info = userInfo as NSDictionary
        
        let articleID = info.object(forKey: RemoteNotificationDeepLinkAppSectionKey) as! String
        
        var ret : RemoteNotificationDeepLink? = nil
        if !articleID.isEmpty
        {
            ret = RemoteNotificationDeepLinkArticle(articleStr: articleID)
        }
        return ret
    }
    
    fileprivate override init()
    {
        self.article = ""
        super.init()
    }
    
    fileprivate init(articleStr: String)
    {
        self.article = articleStr
        super.init()
    }
    
    final func trigger()
    {

        DispatchQueue.main.asynchronously()
        {
            //NSLog("Triggering Deep Link - %@", self)
            self.triggerImp()
                { (passedData) in
                    // do nothing
            }
        }
    }
    
    fileprivate func triggerImp(_ completion: ((AnyObject?)->(Void)))
    {
        
        completion(nil)
    }
}

class RemoteNotificationDeepLinkArticle : RemoteNotificationDeepLink
{
    var articleID : String!
    
    override init(articleStr: String)
    {
        self.articleID = articleStr
        super.init(articleStr: articleStr)
    }
    
    fileprivate override func triggerImp(_ completion: @escaping ((AnyObject?)->(Void)))
    {
        super.triggerImp()
            { (passedData) in
                
                var vc = UIViewController()
                
                // Handle Deep Link Data to present the Article passed through
                
                if self.articleID == "A"
                {
                    vc = ViewControllerA()
                }
                else if self.articleID == "B"
                {
                    vc = ViewControllerB()
                }
                else if self.articleID == "C"
                {
                    vc = ViewControllerC()
                }
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window?.addSubview(vc.view)
                
                completion(nil)
        }
    }
    
}
