//
//  YKRefresh.swift
//  YKSwiftRefresh
//
//  Created by edward on 2023/1/11.
//  Copyright © 2023 Edward（本内容遵循MIT协议） . All rights reserved.
//

import Foundation

// 创建一个通用的刷新处理工具类
public enum YKRefreshError: Error {
    case setupRequired
    case delegateNotFound
}

internal struct YKRefreshHelper {
    static func handleRefresh(mode: YKSwiftRefreshConfigRefreshMode, 
                            scrollView: UIScrollView, 
                            callBack: (()->Void)?) throws {
        guard let delegate = YKSwiftRefreshConfig.share.delegate else {
            throw YKRefreshError.setupRequired
        }
        
        delegate.refreshHandle(mode: mode, scrollView: scrollView, callBack: callBack)
    }
    
    static func addCustomView(mode: YKSwiftRefreshConfigRefreshMode,
                            base: UIScrollView,
                            boundsCallback: @escaping (_ bounds: CGRect) -> UIView?) throws {
        guard let delegate = YKSwiftRefreshConfig.share.delegate else {
            throw YKRefreshError.setupRequired
        }
        
        guard let view = delegate.refreshView?(mode: mode, base: base) else { return }
        
        if let customView = boundsCallback(view.bounds) {
            let backgroundView = UIView(frame: view.bounds)
            if #available(iOS 13.0, *) {
                backgroundView.backgroundColor = UIColor.systemBackground
            } else {
                // Fallback on earlier versions
            }
            backgroundView.addSubview(customView)
            backgroundView.clipsToBounds = true
            view.addSubview(backgroundView)
        }
    }
}





