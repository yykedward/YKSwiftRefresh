//
//  YKRefresh.swift
//  YKSwiftRefresh
//
//  Created by edward on 2023/1/11.
//  Copyright © 2023 Edward（本内容遵循MIT协议） . All rights reserved.
//

import UIKit
import Foundation


//MARK: header
public struct YKSwiftRefreshHeader<Base> {
    internal let base: Base
    internal var includeMJRefresh:Bool = false
    internal init(_ base: Base) {
        self.base = base
    }
}

public protocol YKSwiftRefreshHeaderProtocol {}


extension YKSwiftRefreshHeaderProtocol {
    
    public var ykheader: YKSwiftRefreshHeader<Self> {
        get { return YKSwiftRefreshHeader(self) }
        set {}
    }
}

extension UIScrollView: YKSwiftRefreshHeaderProtocol {}

//MARK: footer
public struct YKSwiftRefreshFooter<Base> {
    internal let base: Base
    internal init(_ base: Base) {
        self.base = base
    }
}

public protocol YKSwiftRefreshFooterProtocol {}

extension YKSwiftRefreshFooterProtocol {
    
    public var ykfooter: YKSwiftRefreshFooter<Self> {
        get { return YKSwiftRefreshFooter(self) }
        set {}
    }
}
extension UIScrollView: YKSwiftRefreshFooterProtocol {}

