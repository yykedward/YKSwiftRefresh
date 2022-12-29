//
//  UIScrollView+YKRefresh.swift
//  YKSwiftRefresh
//
//  Created by edward on 2021/12/22.
//

import Foundation
import UIKit
import ESPullToRefresh

//MARK: 添加刷新
public extension UIScrollView
{
    
    /// 添加头部刷新
    /// - Parameters:
    ///   - view: 头部刷新显示的view
    ///   - viewModel: 刷新修改所用viewModel
    ///   - refreshBlock: 刷新回调
    /// - Returns: 无
    func addRefreshHeader(refreshBlock: (()->Void)?) -> Void {
        let refresh:(()->Void) = {
            if let block = refreshBlock {
                block()
            }
        }
        
        self.es.addPullToRefresh {
            refresh()
        }
        
    }
    
    func addRefreshHeaderView(callBack:(_ headerBounds:CGRect)->UIView?) {
        
        if let header = self.header {
            let callBackView = callBack(header.bounds)
            weak var weakView = callBackView
            if let toAddView = weakView {
                let headerbgView = UIView.init(frame: header.bounds)
                headerbgView.backgroundColor = UIColor.systemBackground
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
    
    /// 添加底部刷新
    /// - Parameters:
    ///   - view: 底部刷新view
    ///   - viewModel: 刷新修改所用viewModel
    ///   - refreshBlock: 刷新回调
    /// - Returns: 无
    func addRefreshFooter(refreshBlock:(()->Void)?) -> Void {
        let refresh:(()->Void) = {
            if let block = refreshBlock {
                block()
            }
        }
        
        self.es.addInfiniteScrolling {
            refresh()
        }
    }
    
    func addRefreshFooterView(callBack:(_ footerBounds:CGRect)->UIView?) {
        
        if let footer = self.footer {
            weak var view = callBack(footer.bounds)
            if let toAddView = view {
                let footerbgView = UIView.init(frame: footer.bounds)
                footerbgView.backgroundColor = UIColor.systemBackground
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
    
    
    /// 头部结束刷新
    /// - Returns: 无
    func headerEndRefresh() -> Void {
        es.stopPullToRefresh()
    }
    
    func footerEndRefresh(noMorData:Bool) -> Void {
        if noMorData {
            es.noticeNoMoreData()
        } else {
            es.stopLoadingMore()
        }
    }
    
    func headerBeginRefresh() -> Void {
        es.startPullToRefresh()
    }
}
