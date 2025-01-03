//
//  UIScrollView+YKRefreshFooter.swift
//  YKSwiftRefresh
//
//  Created by edward on 2023/3/16.
//  Copyright © 2023 Edward（本内容遵循MIT协议） . All rights reserved.
//

import UIKit

//MARK: footer
public struct YKSwiftRefreshFooter<Base> {
    internal let base: Base
    internal init(_ base: Base) {
        self.base = base
    }
}

public protocol YKSwiftRefreshFooterProtocol {}

extension YKSwiftRefreshFooterProtocol {
    
    public var ykfooter: YKSwiftRefreshFooter<Self> {
        get { return YKSwiftRefreshFooter(self) }
        set {}
    }
}
extension UIScrollView: YKSwiftRefreshFooterProtocol {}

public extension YKSwiftRefreshFooter where Base: UIScrollView {
    
    func handler(refreshBlock: (()->Void)?) {
        do {
            try YKRefreshHelper.handleRefresh(mode: .Footer, 
                                            scrollView: base, 
                                            callBack: refreshBlock)
        } catch {
            #if DEBUG
            print("Error: \(error)")
            #endif
        }
    }
    
    func addView(withBoundsCallBack callBack:(_ footerBounds:CGRect)->UIView?) {
        
        if let delegate = YKSwiftRefreshConfig.share.delegate {
            
            if let view = delegate.refreshView?(mode: .Footer, base: self.base) {
                let callBackView = callBack(view.bounds)
                weak var weakView = callBackView
                if let toAddView = weakView {
                    let headerbgView = UIView.init(frame: view.bounds)
                    if #available(iOS 13.0, *) {
                        headerbgView.backgroundColor = UIColor.systemBackground
                    } else {
                        headerbgView.backgroundColor = UIColor.white
                    }
                    headerbgView.addSubview(toAddView)
                    headerbgView.clipsToBounds = true
                    view.addSubview(headerbgView)
                }
            }
            
        } else {
            
            #if DEBUG
            print("请设置 YKSwiftRefreshConfig.setup")
            #endif
        }
    }
    
    func beginRefresh(callBack:(()->Void)? = nil) {
        DispatchQueue.main.async { [weak base] in
            guard let weakBase = base else { return }
            
            let refresh:(()->Void) = {
                if let block = callBack {
                    block()
                }
            }
            
            if let delegate = YKSwiftRefreshConfig.share.delegate {
                delegate.beginRefresh(mode: .Footer, scrollView: weakBase, callBack: refresh)
            }else {
                #if DEBUG
                print("请设置 YKSwiftRefreshConfig.setup")
                #endif
            }
            
            
        }
    }
    
    func endRefresh(noMorData:Bool,callBack:(()->Void)? = nil) {
        
        let refresh:(()->Void) = {
            if let block = callBack {
                block()
            }
        }
        
        if let delegate = YKSwiftRefreshConfig.share.delegate {
            delegate.endRefresh(mode: .Footer, scrollView: self.base, isNoMoreData: noMorData, callBack: refresh)
        }else {
            #if DEBUG
            print("请设置 YKSwiftRefreshConfig.setup")
            #endif
        }
        
        
        
    }
    
}
