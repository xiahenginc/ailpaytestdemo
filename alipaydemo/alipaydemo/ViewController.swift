 //
//  ViewController.swift
//  alipaydemo
//
//  Created by wangxiaoqing on 15/10/29.
//  Copyright © 2015年 wangxiaoqing. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myWebView: UIWebView!
    //var url = "http://192.168.1.104:3000/"
   //var url = "http://www.guorouwang.com/wap_ios3"
     var url = "http://alipaydemo.czjcd.com/"
    var webjs: WebJsHelper?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webjs = WebJsHelper();
        webjs?.createBridge(self.myWebView, vc: self);
        //self.myWebView?.delegate = self;
        loadurl();
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func loadurl(){
        let requestURL = NSURL(string:url)
        let request = NSURLRequest(URL: requestURL!)
        myWebView?.loadRequest(request)
        myWebView?.opaque = false
        myWebView?.backgroundColor = UIColor.clearColor()
    }
}

