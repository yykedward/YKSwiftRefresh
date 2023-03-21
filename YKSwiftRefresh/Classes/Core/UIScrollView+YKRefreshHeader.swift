//
//  UIScrollView+YKRefreshHeader.swift
//  YKSwiftRefresh
//
//  Created by edward on 2021/12/22.
//  Copyright © 2023 Edward（本内容遵循MIT协议） . All rights reserved.
//

import UIKit

public extension YKSwiftRefreshHeader where Base: UIScrollView {
    
    func handler(refreshBlock: (()->Void)?) {
        let refresh:(()->Void) = {
            if let block = refreshBlock {
                block()
            }
        }
        
        if let callBack = YKSwiftRefreshConfig.share.refreshBlock {
            callBack(.Header,self.base,{
                refresh()
            })
        }else {
            
            #if DEBUG
            print("请设置 YKSwiftRefreshConfig.setRefreshBlock")
            #endif
            
        }
        
    }
    
    func addView(withBoundsCallBack callBack:(_ headerBounds:CGRect)->UIView?) {
        
        if let header = YKSwiftRefreshConfig.share.getRefreshViewBlock?(.Header,self.base) {
            
            let callBackView = callBack(header.bounds)
            weak var weakView = callBackView
            if let toAddView = weakView {
                let headerbgView = UIView.init(frame: header.bounds)
                if #available(iOS 13.0, *) {
                    headerbgView.backgroundColor = UIColor.systemBackground
                } else {
                    headerbgView.backgroundColor = UIColor.white
                }
                headerbgView.addSubview(toAddView)
                headerbgView.clipsToBounds = true
                header.addSubview(headerbgView)
            }
            
        }else {
            #if DEBUG
            print("请设置 YKSwiftRefreshConfig.setRefreshBlock")
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
            
            if let refreshBlock = YKSwiftRefreshConfig.share.beginRefreshBlock {
                refreshBlock(.Header,weakBase,{
                    refresh()
                })
            }else {
                #if DEBUG
                print("请设置 YKSwiftRefreshConfig.setBeginRefreshBlock")
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
        
        if let endRefreshBlock = YKSwiftRefreshConfig.share.endRefreshBlock {
            endRefreshBlock(.Header,false,self.base,{
                refresh()
            })
        }else {
            #if DEBUG
            print("请设置 YKSwiftRefreshConfig.setEndRefreshBlock")
            #endif
        }
        
        
    }
}

