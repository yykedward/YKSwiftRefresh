//
//  YKSwiftRefreshConfig.swift
//  YKSwiftRefresh
//
//  Created by edward on 2023/2/7.
//  Copyright © 2023 Edward（本内容遵循MIT协议）. . All rights reserved.
//

import UIKit

public class YKSwiftRefreshConfig: NSObject {
    
    internal static let share = YKSwiftRefreshConfig()
    
    internal var refreshBlock:((_ type:Int, _ base:UIScrollView, _ block:(()->Void)?)->Void)? = nil
    
    internal var beginRefreshBlock:((_ type:Int, _ base:UIScrollView, _ block:(()->Void)?)->Void)? = nil
    
    internal var endRefreshBlock:((_ type:Int, _ isNoMoreData:Bool, _ base:UIScrollView, _ block:(()->Void)?)->Void)? = nil
    
    
    public static func setRefreshBlock(block:((_ type:Int, _ base:UIScrollView, _ block:(()->Void)?)->Void)?) {
        YKSwiftRefreshConfig.share.refreshBlock = block
    }
    
    public static func setEndRefreshBlock(block:((_ type:Int, _ isNoMoreData:Bool, _ base:UIScrollView, _ block:(()->Void)?)->Void)?) {
        YKSwiftRefreshConfig.share.endRefreshBlock = block
    }
    
    public static func setBeginRefreshBlock(block:((_ type:Int, _ base:UIScrollView, _ block:(()->Void)?)->Void)?) {
        YKSwiftRefreshConfig.share.beginRefreshBlock = block
    }
}
