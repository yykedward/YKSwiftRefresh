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
    func addRefreshHeader(view:UIView? = nil, refreshBlock: (()->Void)? = nil) -> Void {
        weak var weakView = view
        let refresh:(()->Void) = {
            if let block = refreshBlock {
                block()
            }
        }
        
        let header = self.es.addPullToRefresh {
            refresh()
        }
        
        
        if let v = weakView {
            let headerbgView = UIView.init(frame: header.bounds)
            headerbgView.addSubview(v)
            header.addSubview(headerbgView)
        }
    }
    
    /// 添加底部刷新
    /// - Parameters:
    ///   - view: 底部刷新view
    ///   - viewModel: 刷新修改所用viewModel
    ///   - refreshBlock: 刷新回调
    /// - Returns: 无
    func addRefreshFooter(view:UIView? = nil, refreshBlock:(()->Void)? = nil) -> Void {
        let refresh:(()->Void) = {
            
            if let block = refreshBlock {
                block()
            }
        }
        
        let footer = self.es.addInfiniteScrolling {
            refresh()
        }
        
        if let v = view {
            let headerbgView = UIView.init(frame: footer.bounds)
            headerbgView.addSubview(v)
            footer.addSubview(headerbgView)
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
