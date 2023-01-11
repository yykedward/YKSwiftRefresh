//
//  YKRefresh.swift
//  YKSwiftRefresh
//
//  Created by linghit on 2023/1/11.
//

import UIKit


//MARK: header
public struct YKSwiftRefreshHeader<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol YKSwiftRefreshHeaderProtocol {}

public extension YKSwiftRefreshHeaderProtocol {
    static var ykheader: YKSwiftRefreshHeader<Self>.Type {
        get { return YKSwiftRefreshHeader<Self>.self }
        set {}
    }
    var ykheader: YKSwiftRefreshHeader<Self> {
        get { return YKSwiftRefreshHeader(self) }
        set {}
    }
}

//MARK: footer
public struct YKSwiftRefreshFooter<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol YKSwiftRefreshFooterProtocol {}

public extension YKSwiftRefreshFooterProtocol {
    static var ykfooter: YKSwiftRefreshFooter<Self>.Type {
        get { return YKSwiftRefreshFooter<Self>.self }
        set {}
    }
    var ykfooter: YKSwiftRefreshFooter<Self> {
        get { return YKSwiftRefreshFooter(self) }
        set {}
    }
}

