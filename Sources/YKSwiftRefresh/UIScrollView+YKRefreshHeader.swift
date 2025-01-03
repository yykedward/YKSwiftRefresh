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
        do {
            try YKRefreshHelper.handleRefresh(mode: .Header, 
                                            scrollView: base, 
                                            callBack: refreshBlock)
        } catch {
            #if DEBUG
            print("Error: \(error)")
            #endif
        }
    }
    
    func addView(withBoundsCallBack callBack: @escaping (_ headerBounds:CGRect)->UIView?) {
        do {
            try YKRefreshHelper.addCustomView(mode: .Header, 
                                            base: base, 
                                            boundsCallback: callBack)
        } catch {
            #if DEBUG
            print("Error: \(error)")
            #endif
        }
    }
    
    func beginRefresh(callBack:(()->Void)? = nil) {
        DispatchQueue.main.async { [weak base] in
            guard let weakBase = base else { return }
            
            if let delegate = YKSwiftRefreshConfig.share.delegate {
                delegate.beginRefresh(mode: .Header, scrollView: weakBase, callBack: callBack)
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

