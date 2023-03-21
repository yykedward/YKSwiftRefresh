//
//  UIScrollView+YKRefreshFooter.swift
//  YKSwiftRefresh
//
//  Created by linghit on 2023/3/16.
//  Copyright © 2023 Edward（本内容遵循MIT协议） . All rights reserved.
//

import UIKit


public extension YKSwiftRefreshFooter where Base: UIScrollView {
    
    func handler(refreshBlock: (()->Void)?) {
        let refresh:(()->Void) = {
            if let block = refreshBlock {
                block()
            }
        }
        
        if let refreshBlock = YKSwiftRefreshConfig.share.refreshBlock {
            refreshBlock(.Footer,self.base,{
                refresh()
            })
        }else {
            #if DEBUG
            print("请设置 YKSwiftRefreshConfig.setRefreshBlock")
            #endif
                
        }
        
        
    }
    
    func addView(withBoundsCallBack callBack:(_ footerBounds:CGRect)->UIView?) {
        
        if let footer = YKSwiftRefreshConfig.share.getRefreshViewBlock?(.Footer,self.base) {
            
            weak var view = callBack(footer.bounds)
            if let toAddView = view {
                let footerbgView = UIView.init(frame: footer.bounds)
                if #available(iOS 13.0, *) {
                    footerbgView.backgroundColor = UIColor.systemBackground
                } else {
                    footerbgView.backgroundColor = UIColor.white
                }
                footerbgView.addSubview(toAddView)
                footerbgView.clipsToBounds = true
                footer.addSubview(footerbgView)
            }
            
        }else {
            #if DEBUG
            print("请设置 YKSwiftRefreshConfig.setGetRefreshViewBlock")
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
                refreshBlock(.Footer,weakBase,{
                    refresh()
                })
            }else {
                #if DEBUG
                print("请设置 YKSwiftRefreshConfig.setBeginRefreshBlock")
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
        
        if let endRefreshBlock = YKSwiftRefreshConfig.share.endRefreshBlock {
            endRefreshBlock(.Footer,noMorData,self.base,{
                refresh()
            })
        }else {
            #if DEBUG
            print("请设置 YKSwiftRefreshConfig.setEndRefreshBlock")
            #endif
        }
        
        
        
    }
    
}
