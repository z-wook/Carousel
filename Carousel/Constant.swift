//
//  Constant.swift
//  Carousel
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import UIKit

enum Constant {
    static let itemSize = CGSize(width: 300, height: 400)
    static let itemSpacing: CGFloat = 24
    static let cornerRadius: CGFloat = 20
    
    static var insetX: CGFloat {
        (UIScreen.main.bounds.width - Self.itemSize.width) / 2
    }
    static var collectionViewContentInset: UIEdgeInsets {
        UIEdgeInsets(top: 0, left: Self.insetX, bottom: 0, right: Self.insetX)
    }
}
