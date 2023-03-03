//
//  YKRefresh.swift
//  YKSwiftRefresh
//
//  Created by linghit on 2023/1/11.
//

import UIKit


//MARK: header
public struct YKSwiftRefreshHeader<Base> {
    internal let base: Base
    internal init(_ base: Base) {
        self.base = base
    }
}

public protocol YKSwiftRefreshHeaderProtocol {}

public extension YKSwiftRefreshHeaderProtocol {
    
    var ykheader: YKSwiftRefreshHeader<Self> {
        get { return YKSwiftRefreshHeader(self) }
        set {}
    }
}

//MARK: footer
public struct YKSwiftRefreshFooter<Base> {
    internal let base: Base
    internal init(_ base: Base) {
        self.base = base
    }
}

public protocol YKSwiftRefreshFooterProtocol {}

public extension YKSwiftRefreshFooterProtocol {
    
    var ykfooter: YKSwiftRefreshFooter<Self> {
        get { return YKSwiftRefreshFooter(self) }
        set {}
    }
}

