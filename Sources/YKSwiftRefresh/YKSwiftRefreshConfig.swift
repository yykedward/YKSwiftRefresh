//
//  YKSwiftRefreshConfig.swift
//  YKSwiftRefresh
//
//  Created by edward on 2023/2/7.
//  Copyright © 2023 Edward（本内容遵循MIT协议） . All rights reserved.
//

import UIKit

@objc public enum YKSwiftRefreshConfigRefreshMode:Int {
    case Header = 0
    case Footer = 1
}

@objc public protocol YKSwiftRefreshConfigDelegate {
    
    func refreshHandle(mode: YKSwiftRefreshConfigRefreshMode, scrollView: UIScrollView, callBack:(()->Void)?)
    
    func beginRefresh(mode:YKSwiftRefreshConfigRefreshMode, scrollView: UIScrollView, callBack:(()->Void)?)
    
    func endRefresh(mode:YKSwiftRefreshConfigRefreshMode, scrollView: UIScrollView, isNoMoreData:Bool, callBack:(()->Void)?)
    
    @objc optional func refreshView(type:YKSwiftRefreshConfigRefreshMode, base:UIScrollView) -> UIView?
}

public class YKSwiftRefreshConfig: NSObject {
    
    internal static let share = YKSwiftRefreshConfig()
    
    internal weak var delegate:YKSwiftRefreshConfigDelegate? = nil
    
    private override init() {
        super.init()
    }
    
}

extension YKSwiftRefreshConfig {
    
    public static func setup(delegate:YKSwiftRefreshConfigDelegate?) {
        YKSwiftRefreshConfig.share.delegate = delegate
    }
}
