//
//  ViewController.swift
//  Carousel
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import UIKit
import SwiftUI
import SnapKit

final class ViewController: UIViewController {
    private let backView = BackgroundView(frame: .zero)
    private let pictureView = PictureView(frame: .zero)
    private let imageBaseName: String = "picture"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        configure()
        setLayout()
    }
    
    func configure() {
        pictureView.collectionView.dataSource = self
        pictureView.collectionView.delegate = self
        pictureView.collectionView.prefetchDataSource = self
        backView.backgroundView.image = UIImage(named: imageBaseName + "0")
    }
    
    func setLayout() {
        [backView, pictureView].forEach {
            view.addSubview($0)
        }
        
        backView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        pictureView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 11
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PictureCell.identifier,
                                                            for: indexPath) as? PictureCell else { return UICollectionViewCell() }
        let imageName = imageBaseName + "\(indexPath.item)"
        let image = ImageCacheManager.shared.loadImage(imgName: imageName)
        cell.configure(img: image)
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
}

extension ViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            let imageName = imageBaseName + "\(indexPath.item)"
            ImageCacheManager.shared.prefetchImage(imgName: imageName)
        }
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / self.pictureView.bounds.width)
        backView.backgroundView.image = UIImage(named: imageBaseName + "\(index)")
    }
}

// SwiftUI를 활용한 미리보기
struct mainViewController_Previews: PreviewProvider {
    static var previews: some View {
        mainVCReprsentable().edgesIgnoringSafeArea(.all)
    }
}

struct mainVCReprsentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let mainViewController = ViewController()
        return UINavigationController(rootViewController: mainViewController)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
    typealias UIViewControllerType = UIViewController
}
