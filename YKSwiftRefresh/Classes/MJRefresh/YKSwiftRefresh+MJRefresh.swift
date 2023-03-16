//
//  YKSwiftRefresh+MJRefresh.swift
//  YKSwiftRefresh
//
//  Created by edward on 2023/3/3.
//  Copyright © 2023 Edward（本内容遵循MIT协议）. . All rights reserved.
//

import UIKit
import Foundation

//MARK: header
public struct YKSwiftMJRefreshHeader<Base> {
    internal let mj_base: Base
    internal init(_ base: Base) {
        self.mj_base = base
    }
}

public extension YKSwiftRefreshHeaderProtocol {
    
    var mjheader: YKSwiftMJRefreshHeader<Self> {
        get { return YKSwiftMJRefreshHeader(self) }
        set {}
    }
}

//MARK: footer
public struct YKSwiftMJRefreshFooter<Base> {
    internal let mj_base: Base
    internal init(_ base: Base) {
        self.mj_base = base
    }
}


public extension YKSwiftRefreshFooterProtocol {
    
    var mjfooter: YKSwiftMJRefreshFooter<Self> {
        get { return YKSwiftMJRefreshFooter(self) }
        set {}
    }
}
