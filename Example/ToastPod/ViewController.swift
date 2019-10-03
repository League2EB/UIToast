//
//  ViewController.swift
//  ToastPod
//
//  Created by taiwanlastone on 08/24/2017.
//  Copyright (c) 2017 taiwanlastone. All rights reserved.
//

import UIKit
import ToastPod

class ViewController: UIViewController {

    let longText = "ｗｉｌｌ　ｙｏｕ　ｈａｖｅ　ａｎ　ｐｅｎ．"
    let shortText = "註冊成功"
    let chineseText = "這是一段很長很長很長很長很長很長很長很長很長很長很長很長很長很長很長很長很長很長很長很長很長很長很長很長很長很長很長很長很長很長很長很長很長的文字"

    var activity: UIView? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func showBaseToast(_ sender: Any) {
        //Toast.showBaseToast(self.view, message: longText)

        let style = ToastStyle(backgroundColor: #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 0.7), cornerRadius: 10, textColor: UIColor.white, font: 20, numberOfLines: 3)
        Toast.showBaseToast(self.view, message: chineseText, style: style)
    }

    @IBAction func showImgToast(_ sender: Any) {
        Toast.showImageToast(self.view, message: shortText, img: #imageLiteral(resourceName: "correct"))
    }

    @IBAction func showActivityIndicatorView(_ sender: Any) {
        let style = ActivityIndicatorStyle(backgroundColor: #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 0.7), maskColor: #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 0.2), cornerRadius: 8)
        Toast.showActivityIndicator(self.view, style: style)

        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            Toast.hiddenActivityIndicator()
        }
    }
}

