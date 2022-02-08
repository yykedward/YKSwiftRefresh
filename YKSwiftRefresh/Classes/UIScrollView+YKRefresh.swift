//
//  UIScrollView+YKRefresh.swift
//  YKSwiftRefresh
//
//  Created by edward on 2021/12/22.
//

import Foundation
import UIKit
import ESPullToRefresh
import YKSwiftBaseClass

extension UIScrollView
{
    
    public func addRefreshHeader(view:UIView?, viewModel:YKViewModel?, refreshBlock: (()->Void)? = nil) -> Void {
        let refresh:(()->Void) = {
            if let vm = viewModel {
                vm.page = 1
            }
            if let block = refreshBlock {
                block()
            }
        }
        
        let header = self.es.addPullToRefresh {
            refresh()
        }
        
        
        if let v = view {
            let headerbgView = UIView.init(frame: header.bounds)
            headerbgView.addSubview(v)
            header.addSubview(headerbgView)
        }
    }
    
    public func addRefreshHeader(viewModel:YKViewModel?, refreshBlock:(()->Void)?) -> Void {
        addRefreshHeader(view: nil, viewModel: viewModel, refreshBlock: refreshBlock)
    }
    
    public func addRefreshHeader(view:UIView?, refreshBlock:(()->Void)?) -> Void {
        addRefreshHeader(view: view, viewModel: nil, refreshBlock: refreshBlock)
    }
    
    public func addRefreshHeader(refreshBlock:(()->Void)?) -> Void {
        addRefreshHeader(view: nil, viewModel: nil, refreshBlock: refreshBlock)
    }
    
    public func addRefreshFooter(view:UIView?, viewModel:YKViewModel?, refreshBlock:(()->Void)?) -> Void {
        let refresh:(()->Void) = {
            if let vm = viewModel {
                vm.page = vm.page + 1
            }
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
    
    public func addRefreshFooter(viewModel:YKViewModel?, refreshBlock:(()->Void)?) -> Void {
        addRefreshFooter(view: nil, viewModel: viewModel, refreshBlock: refreshBlock)
    }
    
    public func addRefreshFooter(view:UIView?, refreshBlock:(()->Void)?) -> Void {
        addRefreshFooter(view: view, viewModel: nil, refreshBlock: refreshBlock)
    }
    
    public func addRefreshFooter(refreshBlock:(()->Void)?) -> Void {
        addRefreshFooter(view: nil, viewModel: nil, refreshBlock: refreshBlock)
    }
    
    
    public func headerEndRefresh() -> Void {
        es.stopPullToRefresh()
    }
    
    public func footerEndRefresh(noMorData:Bool) -> Void {
        if noMorData {
            es.noticeNoMoreData()
        } else {
            es.stopLoadingMore()
        }
    }
    
    public func headerBeginRefresh() -> Void {
        es.startPullToRefresh()
    }
}
