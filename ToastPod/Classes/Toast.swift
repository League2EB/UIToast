//
//  Toast.swift
//  Pods
//
//  Created by kellychen on 2017/8/25.
//
//


import Foundation

public struct ActivityIndicatorStyle {
    
    var backgroundColor: UIColor
    var maskColor: UIColor
    var cornerRadius: CGFloat
    
    public init(backgroundColor: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.8), maskColor: UIColor = UIColor.clear, cornerRadius: CGFloat = 6) {
        self.backgroundColor = backgroundColor
        self.maskColor = maskColor
        self.cornerRadius = cornerRadius
    }
}

public struct ToastStyle {
    
    var backgroundColor: UIColor
    var cornerRadius: CGFloat
    var textColor: UIColor
    var font: CGFloat
    
    /** 
     文字訊息最大行數
    */
    var numberOfLines:Int

    public init(backgroundColor: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.8), cornerRadius: CGFloat = 6, textColor: UIColor = UIColor.white, font: CGFloat = 14, numberOfLines: Int = 3 ) {
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.textColor = textColor
        self.font = font
        self.numberOfLines = numberOfLines
    }
}

public class Toast {

    private static let padding: CGFloat = 8
    private static let viewBottomPadding: CGFloat = 60
    private static var activityIndicatorView:UIView? = nil

    public static func showBaseToast(_ showView:UIView, message:String, style:ToastStyle = ToastStyle()) {

        let size = getToastSize(showView, message:message, style:style)
        
        let view = UIView(frame: CGRect(x: 0, y: showView.frame.size.height - viewBottomPadding - (size.height + 16), width: size.width + padding * 2, height: size.height + padding * 2))
        view.setViewStyle(showView, style: style)
        
        let label = UILabel(frame: CGRect(x: padding, y: 0, width: size.width, height: view.frame.height))
        label.setLabelStyle(showView, style: style)
        label.text = message
        view.addSubview(label)
        
        showView.addSubview(view)
        hiddenToastAfterTime(view)
    }

    public static func showImageToast(_ showView: UIView, message: String, img: UIImage,style: ToastStyle = ToastStyle()) {
        
        var size = getToastSize(showView, message: message, style: style)

        //圖片訊息最小寬度
        let imgToastMinWidth: CGFloat = 120
        
        size.width = (size.width < imgToastMinWidth) ? imgToastMinWidth : size.width
        
        let imgFrameViewHeight: CGFloat = 60
        let toastHieght: CGFloat = imgFrameViewHeight + size.height + padding * 2
        
        let view = UIView(frame: CGRect(x: 0, y: showView.frame.size.height/2 - toastHieght/2, width: size.width + padding * 2, height: toastHieght))
        view.setViewStyle(showView, style: style)
        
        let imgSize:CGFloat = 24
        let imgView = UIImageView(frame: CGRect(x: view.frame.size.width / 2 - (imgSize / 2), y: (imgFrameViewHeight - imgSize)/2, width: imgSize, height: imgSize))
        
        imgView.image = img
        imgView.contentMode = .center
        view.addSubview(imgView)
        
        let label = UILabel(frame: CGRect(x: padding, y: imgFrameViewHeight, width: size.width, height: size.height))
        label.setLabelStyle(showView, style: style)
        label.text = message
        view.addSubview(label)
        
        showView.addSubview(view)
        hiddenToastAfterTime(view)
    }
    
    public static func showActivityIndicator(_ showView: UIView, style: ActivityIndicatorStyle = ActivityIndicatorStyle()) {
        
        guard activityIndicatorView == nil else { return }
        
        //遮罩
        let mask = UIView(frame: CGRect(x: 0, y: 0, width:showView.frame.size.width, height: showView.frame.size.height))
        mask.backgroundColor = style.maskColor
        
        let toastSize:CGFloat = 120
        let toastView = UIView(frame: CGRect(x: 0, y: mask.frame.size.height / 2 - (toastSize / 2), width: toastSize, height: toastSize))
        toastView.backgroundColor = style.backgroundColor
        toastView.layer.cornerRadius = style.cornerRadius
        toastView.clipsToBounds = true
        toastView.center.x = mask.bounds.width / 2
        
        let activityView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        activityView.frame = CGRect(x: 0, y: 0, width: toastSize, height: toastSize)
        activityView.startAnimating()
        
        toastView.addSubview(activityView)
        mask.addSubview(toastView)
        showView.addSubview(mask)
        activityIndicatorView = mask
    }
    
    public static func hiddenActivityIndicator() {
        if let view = activityIndicatorView {
            view.removeFromSuperview()
            activityIndicatorView = nil
        }
    }

    private static func getToastSize(_ showView: UIView, message: String, style: ToastStyle) -> CGSize {
        let string: NSString = message as NSString
        
        //依照文字內容調整寬度
        var size: CGSize = string.size(withAttributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: style.font)])
        size.width = size.width + (style.font / 2)
        
        //最大寬度為螢幕的2/3
        let maxWidth: CGFloat = showView.frame.size.width * 2 / 3
        size.width = (size.width < maxWidth) ? size.width : maxWidth
        
        //取得文字高度
        let size2 = string.boundingRect(with: CGSize(width: size.width, height: CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: style.font)], context: nil)
        
        //最大高度為行數+1*字體大小
        let maxHeight: CGFloat = CGFloat(style.numberOfLines + 1) * style.font
        size.height = (size2.height <  maxHeight) ? size2.height : maxHeight
        
        return size
    }
    
    //時間之後隱藏Toast
    private static func hiddenToastAfterTime(_ view:UIView) {
        UIView.animate(withDuration: 0.7, delay: 2.0, options: .curveEaseOut, animations: {
            view.alpha = 0.0
        }, completion: {(isCompleted) in
            view.removeFromSuperview()
        })
    }
}

extension UIView {
    
    func setViewStyle(_ showView: UIView, style: ToastStyle) {
        self.backgroundColor = style.backgroundColor
        self.layer.cornerRadius = style.cornerRadius
        self.clipsToBounds = true
        self.center.x = showView.bounds.width / 2
    }
}

extension UILabel {
    
    func setLabelStyle(_ showView: UIView, style: ToastStyle) {
        self.textColor = style.textColor
        self.textAlignment = .center
        self.numberOfLines = style.numberOfLines
        self.font = UIFont.boldSystemFont(ofSize: style.font)
        self.lineBreakMode = .byWordWrapping
    }
}
