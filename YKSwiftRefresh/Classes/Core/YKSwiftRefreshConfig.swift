//
//  YKSwiftRefreshConfig.swift
//  YKSwiftRefresh
//
//  Created by edward on 2023/2/7.
//  Copyright © 2023 Edward（本内容遵循MIT协议）. . All rights reserved.
//

import UIKit

@objc public enum YKSwiftRefreshConfigRefreshMode:Int {
    case Header = 0
    case Footer = 1
}

public class YKSwiftRefreshConfig: NSObject {
    
    internal static let share = YKSwiftRefreshConfig()
    
    internal var refreshBlock:((_ mode:YKSwiftRefreshConfigRefreshMode, _ base:UIScrollView, _ block:(()->Void)?)->Void)? = nil
    
    internal var beginRefreshBlock:((_ mode:YKSwiftRefreshConfigRefreshMode, _ base:UIScrollView, _ block:(()->Void)?)->Void)? = nil
    
    internal var endRefreshBlock:((_ mode:YKSwiftRefreshConfigRefreshMode, _ isNoMoreData:Bool, _ base:UIScrollView, _ block:(()->Void)?)->Void)? = nil
    
    internal var getRefreshViewBlock:((_ type:YKSwiftRefreshConfigRefreshMode, _ base:UIScrollView)->UIView?)? = nil
    
    
    public static func setRefreshBlock(block:((_ mode:YKSwiftRefreshConfigRefreshMode, _ base:UIScrollView, _ block:(()->Void)?)->Void)?) {
        YKSwiftRefreshConfig.share.refreshBlock = block
    }
    
    public static func setEndRefreshBlock(block:((_ mode:YKSwiftRefreshConfigRefreshMode, _ isNoMoreData:Bool, _ base:UIScrollView, _ block:(()->Void)?)->Void)?) {
        YKSwiftRefreshConfig.share.endRefreshBlock = block
    }
    
    public static func setBeginRefreshBlock(block:((_ mode:YKSwiftRefreshConfigRefreshMode, _ base:UIScrollView, _ block:(()->Void)?)->Void)?) {
        YKSwiftRefreshConfig.share.beginRefreshBlock = block
    }
    
    public static func setGetRefreshViewBlock(block:((_ type:YKSwiftRefreshConfigRefreshMode, _ base:UIScrollView)->UIView?)?) {
        YKSwiftRefreshConfig.share.getRefreshViewBlock = block
    }
}
