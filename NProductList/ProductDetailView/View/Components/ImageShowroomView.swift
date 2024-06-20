//
//  ImageShowroomView.swift
//  NProductList
//
//  Created by Can Özcan on 18.06.2024.
//

import UIKit
import SnapKit

class ImageShowroomView: UIView {
    
    var imageUrlList: [String] = [] {
        didSet {
            pageControl.currentPage = .zero
            pageControl.numberOfPages = imageUrlList.count
            collectionView.reloadData()
        }
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = .zero
        
        let collectionViewTemp = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionViewTemp.isPagingEnabled = true
        collectionViewTemp.showsHorizontalScrollIndicator = false
        collectionViewTemp.translatesAutoresizingMaskIntoConstraints = false
        collectionViewTemp.delegate = self
        collectionViewTemp.dataSource = self
        collectionViewTemp.register(ImageShowroomCell.self, forCellWithReuseIdentifier: "ImageShowroomCell")
        addSubview(collectionViewTemp)
        return collectionViewTemp
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControlTemp = UIPageControl()
        pageControlTemp.currentPage = 0
        pageControlTemp.numberOfPages = 5
        pageControlTemp.translatesAutoresizingMaskIntoConstraints = false
        pageControlTemp.pageIndicatorTintColor = .lightGray
        pageControlTemp.currentPageIndicatorTintColor = .black
        addSubview(pageControlTemp)
        return pageControlTemp
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-5)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(pageControl.snp.top).offset(-5)
        }
        
    }
    
}

extension ImageShowroomView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
}

extension ImageShowroomView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageUrlList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageShowroomCell", for: indexPath) as! ImageShowroomCell
        cell.imageUrl = imageUrlList[indexPath.item]
        return cell
    }
    
}


class ImageShowroomCell: UICollectionViewCell {
    
    private lazy var imageView: UIImageView = {
        let imageViewTemp = UIImageView()
        imageViewTemp.contentMode = .scaleAspectFit
        imageViewTemp.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageViewTemp)
        return imageViewTemp
    }()
    
    var imageUrl: String? {
        didSet {
            imageView.loadImageFromURL(urlString: imageUrl.stringValue)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        
        imageView.snp.makeConstraints { make in
            make.center.width.height.equalToSuperview()
        }
        
    }
    
}
