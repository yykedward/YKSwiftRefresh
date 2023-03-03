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
        
        self.mj.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            refresh()
        })
        
    }
    
    func begin(refreshCallBack: (()->Void)? = nil) {
        self.mj.mj_header?.beginRefreshing {
            refreshCallBack?()
        }
    }
    
    func end(endCallBack:(()->Void)? = nil) {
        self.mj.mj_header?.endRefreshing {
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
        
        self.mj.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {
            refresh()
        })
        
    }
    
    func begin(refreshCallBack: (()->Void)? = nil) {
        self.mj.mj_footer?.beginRefreshing {
            refreshCallBack?()
        }
    }
    
    func end(isNoMoreData:Bool, endCallBack:(()->Void)? = nil) {
        
        self.mj.mj_footer?.endRefreshingCompletionBlock = {
            endCallBack?()
        }
        
        if isNoMoreData {
            self.mj.mj_footer?.endRefreshingWithNoMoreData()
        }else {
            self.mj.mj_footer?.endRefreshing()
        }
    }
}
