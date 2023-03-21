//
//  UIScrollView+YKMJRefresh.swift
//  YKSwiftRefresh
//
//  Created by edward on 2023/3/3.
//  Copyright © 2023 Edward（本内容遵循MIT协议）. . All rights reserved.
//

import UIKit
import MJRefresh

public extension YKSwiftMJRefreshHeader where Base: UIScrollView {
    
    func handler(refreshCallBack: (()->Void)?) {
        let refresh = {
            if let block = refreshCallBack {
                block()
            }
        }
        
        self.mj_base.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            refresh()
        })
        
    }
    
    func addView(withBoundsCallBack callBack:(_ footerBounds:CGRect)->UIView?) {
        
        if let header = self.mj_base.mj_header {
            
            weak var view = callBack(header.bounds)
            if let toAddView = view {
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
            
        }
    }
    
    func beginRefresh(refreshCallBack: (()->Void)? = nil) {
        self.mj_base.mj_header?.beginRefreshing {
            refreshCallBack?()
        }
    }
    
    func endRefresh(endCallBack:(()->Void)? = nil) {
        self.mj_base.mj_header?.endRefreshing {
            endCallBack?()
        }
    }
    
}

public extension YKSwiftMJRefreshFooter where Base: UIScrollView {
    
    func handler(refreshBlock: (()->Void)?) {
        let refresh:(()->Void) = {
            if let block = refreshBlock {
                block()
            }
        }
        
        self.mj_base.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {
            refresh()
        })
        
    }
    
    func addView(withBoundsCallBack callBack:(_ footerBounds:CGRect)->UIView?) {
        
        if let footer = self.mj_base.mj_footer {
            
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
            
        }
    }
    
    func beginRefresh(refreshCallBack: (()->Void)? = nil) {
        self.mj_base.mj_footer?.beginRefreshing {
            refreshCallBack?()
        }
    }
    
    func endRefresh(isNoMoreData:Bool, endCallBack:(()->Void)? = nil) {
        
        self.mj_base.mj_footer?.endRefreshingCompletionBlock = {
            endCallBack?()
        }
        
        if isNoMoreData {
            self.mj_base.mj_footer?.endRefreshingWithNoMoreData()
        }else {
            self.mj_base.mj_footer?.endRefreshing()
        }
    }
}
