//
//  UIScrollView+YKRefreshHeader.swift
//  YKSwiftRefresh
//
//  Created by edward on 2021/12/22.
//  Copyright © 2023 Edward（本内容遵循MIT协议） . All rights reserved.
//

import UIKit

//MARK: header
public struct YKSwiftRefreshHeader<Base> {
    internal let base: Base
    internal var includeMJRefresh:Bool = false
    internal init(_ base: Base) {
        self.base = base
    }
}

public protocol YKSwiftRefreshHeaderProtocol {}


extension YKSwiftRefreshHeaderProtocol {
    
    public var ykheader: YKSwiftRefreshHeader<Self> {
        get { return YKSwiftRefreshHeader(self) }
        set {}
    }
}

extension UIScrollView: YKSwiftRefreshHeaderProtocol {}



public extension YKSwiftRefreshHeader where Base: UIScrollView {
    
    func handler(refreshBlock: (()->Void)?) {
        let refresh:(()->Void) = {
            if let block = refreshBlock {
                block()
            }
        }
        
        if let delegate = YKSwiftRefreshConfig.share.delegate {
            
            delegate.refreshHandle(mode: .Header, scrollView: base, callBack: refresh)
        }else {
            
            #if DEBUG
            print("请设置 YKSwiftRefreshConfig.setup")
            #endif
            
        }
        
    }
    
    func addView(withBoundsCallBack callBack:(_ headerBounds:CGRect)->UIView?) {
        
        if let delegate = YKSwiftRefreshConfig.share.delegate {
            
            if let view = delegate.refreshView?(type: .Header, base: self.base) {
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
                delegate.beginRefresh(mode: .Header, scrollView: weakBase, callBack: refresh)
            }else {
                #if DEBUG
                print("请设置 YKSwiftRefreshConfig.setup")
                #endif
                
            }
        }
    }
    
    func endRefresh(callBack:(()->Void)? = nil) {
        
        let refresh:(()->Void) = {
            if let block = callBack {
                block()
            }
        }
        
        if let delegate = YKSwiftRefreshConfig.share.delegate {
            delegate.endRefresh(mode: .Header, scrollView: base, isNoMoreData: false, callBack: refresh)
        }else {
            #if DEBUG
            print("请设置 YKSwiftRefreshConfig.setup")
            #endif
        }
        
        
    }
}

