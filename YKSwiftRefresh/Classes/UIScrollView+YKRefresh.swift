//
//  UIScrollView+YKRefresh.swift
//  YKSwiftRefresh
//
//  Created by edward on 2021/12/22.
//

import Foundation
import UIKit
import MJRefresh


extension UIScrollView: YKSwiftRefreshHeaderProtocol {}

public extension YKSwiftRefreshHeader where Base: UIScrollView {
    
    func handler(refreshBlock: (()->Void)?) {
        let refresh:(()->Void) = {
            if let block = refreshBlock {
                block()
            }
        }
        
        self.base.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            refresh()
        })
    }
    
    func add(viewWithBoundsCallBack callBack:(_ headerBounds:CGRect)->UIView?) {
        if let header = self.base.mj_header {
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
            print("\(self)未设置刷新头部刷新view")
            #endif
        }
    }
    
    func refresh(callBack:(()->Void)? = nil) {
        DispatchQueue.main.async { [weak base] in
            guard let weakBase = base else { return }
            
            let refresh:(()->Void) = {
                if let block = callBack {
                    block()
                }
            }
            
            weakBase.mj_header?.beginRefreshing {
                refresh()
            }
        }
    }
    
    func endRefresh(callBack:(()->Void)? = nil) {
        
        let refresh:(()->Void) = {
            if let block = callBack {
                block()
            }
        }
        
        self.base.mj_header?.endRefreshing {
            refresh()
        }
    }
}


extension UIScrollView: YKSwiftRefreshFooterProtocol {}

public extension YKSwiftRefreshFooter where Base: UIScrollView {
    
    func handler(refreshBlock: (()->Void)?) {
        let refresh:(()->Void) = {
            if let block = refreshBlock {
                block()
            }
        }
        self.base.mj_footer = MJRefreshBackNormalFooter.init(refreshingBlock: {
            refresh()
        })
    }
    
    func add(viewWithBoundsCallBack callBack:(_ footerBounds:CGRect)->UIView?) {
        if let footer = self.base.mj_footer {
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
            print("\(self)未设置刷新底部刷新view")
            #endif
        }
    }
    
    func refresh(callBack:(()->Void)? = nil) {
        DispatchQueue.main.async { [weak base] in
            guard let weakBase = base else { return }
            
            let refresh:(()->Void) = {
                if let block = callBack {
                    block()
                }
            }
            
            weakBase.mj_footer?.beginRefreshing {
                refresh()
            }
        }
    }
    
    func endRefresh(noMorData:Bool,callBack:(()->Void)? = nil) {
        
        let refresh:(()->Void) = {
            if let block = callBack {
                block()
            }
        }
        
        self.base.mj_footer?.endRefreshingCompletionBlock = {
            refresh()
        }
        
        if noMorData {
            self.base.mj_footer?.endRefreshingWithNoMoreData()
        } else {
            self.base.mj_footer?.endRefreshing()
        }
    }
}
