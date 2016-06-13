//
//  ViewController.swift
//  Test
//
//  Created by Justin on 16/6/13.
//  Copyright © 2016年 Justin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let fileManager = NSFileManager.defaultManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = NSBundle .mainBundle().pathForResource("text", ofType: "plist")
        let array: NSArray = NSArray(contentsOfFile: path!)!
        
        self.sessionSimpleDownload(array[0] as! NSString,index: 0)
        self.sessionSimpleDownload(array[1] as! NSString,index: 1)
        self.sessionSimpleDownload(array[2] as! NSString,index: 2)
        
    }
    
    func sessionSimpleDownload(path: NSString,index: NSInteger) {
        //存放写入数据文件的路径
        let home = NSHomeDirectory() + "/Documents/\(index)write.text"
        //存放读取数据文件的路径
        let read = NSHomeDirectory() + "/Documents/\(index)read.text"
        let url: NSURL = NSURL(string: path as String)!
        let request: NSURLRequest = NSURLRequest(URL: url)
        let session = NSURLSession.sharedSession()
        
        let dataStack = session.dataTaskWithRequest(request) { (data: NSData?, response: NSURLResponse?, error: NSError?) in
        self.fileManager.createFileAtPath(home, contents: data, attributes: nil)
            
            data?.writeToFile(home, atomically: true)
            print(home)
//            print(NSString(data: data!, encoding:NSUTF8StringEncoding ))
            let fileHandle: NSFileHandle = NSFileHandle()
            let filePath = NSFileHandle(forReadingAtPath: home)//打开一个文件准备读取
            let fileData = filePath!.availableData // 从设备或者通道返回可用的数据
            fileData.writeToFile(read, atomically: true)  //NSData数据写入文件
            fileHandle.closeFile() //关闭文件 ... ...
            print("读写数据完成！")
        }
            dataStack.resume()


}
}

