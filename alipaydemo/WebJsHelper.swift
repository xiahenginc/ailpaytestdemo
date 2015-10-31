//
//  WebJsHelper.swift
//  jyjp
//
//  Created by wangxiaoqing on 15/8/20.
//  Copyright (c) 2015年 jyjp.xiaheng.net. All rights reserved.
//

import Foundation

class WebJsHelper:NSObject {
    var bridge: WebViewJavascriptBridge?
    var myWebView:UIWebView?
     
    func createBridge(webview:UIWebView?,vc:ViewController?){
        self.myWebView = webview
        WebViewJavascriptBridge.enableLogging()
       
        self.bridge = WebViewJavascriptBridge(forWebView: myWebView, handler: {
            data, responseCallback in
        })
        

        //--------------------------------------------------------------------
        bridge?.registerHandler("alipaygrwhandler" ,handler: {
        data, responseCallback in
        
            let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDel.alipayResult = {
            jsonRes in
            responseCallback(jsonRes.object)
            }
            
            let json = JSON(data)
            if let orderinfo = json["param1"].string{
            
                print("\(orderinfo)");
                AlipaySDK.defaultService().payOrder(orderinfo, fromScheme: "alipaygrw") { (result: [NSObject: AnyObject]!) -> Void in
                var resultTxt:String!="failed"
                var txt:String! = "支付失败"
                if (result != nil) {
                print("\(result)")
                txt = result["memo"] as! String
                let status = result["resultStatus"] as! NSObject
                if ("\(status)" == "9000") {
                
                resultTxt = "success"
                }
            }
            else{
                    txt =  "无法获取结果"
            }
            let jsonRes = JSON(["type":"res","param1":resultTxt,"param2":txt])
            responseCallback(jsonRes.object)
            
            }
            
            }
        })
       
    }
};