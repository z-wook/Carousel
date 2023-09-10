//
//  BackgroundView.swift
//  Carousel
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import UIKit
import SnapKit

final class BackgroundView: UIView {
    lazy var backgroundView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private lazy var whiteView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.alpha = 0.2
        return view
    }()
    
//    private lazy var blurView: UIVisualEffectView = {
//        let blurEffect = UIBlurEffect(style: .regular) // 블러 스타일 선택
//        let view = UIVisualEffectView(effect: blurEffect)
//        return view
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    private func setLayout() {
        self.addSubview(backgroundView)
        
        self.addSubview(whiteView)
        
//        [backgroundView, blurView].forEach {
//            self.addSubview($0)
//        }
        
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        whiteView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
//        blurView.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
