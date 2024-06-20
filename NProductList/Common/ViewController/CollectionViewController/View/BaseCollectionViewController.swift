//
//  BaseCollectionViewController.swift
//  NProductList
//
//  Created by Can Özcan on 7.06.2024.
//

import UIKit
import SnapKit

protocol BaseCollectionViewDisplayLogic: BaseViewDisplayLogic {
    func displaySections(sections: [BaseCollectionSectionProtocol])
    func updateSection(sectionIndex: Int, section: BaseCollectionSectionProtocol)
    func updateEndOfCollection()
}

class BaseCollectionViewController: BaseViewController,
                                    BaseCollectionViewDisplayLogic {
    
    private enum Constants {
        static let bottomThreshold = 5
    }
    
    private var isUpdatingBottom: Bool = false
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionViewTemp: UICollectionView = .init(frame: .zero, collectionViewLayout: layout)
        collectionViewTemp.translatesAutoresizingMaskIntoConstraints = false
        collectionViewTemp.dataSource = self
        collectionViewTemp.delegate = self
        collectionViewTemp.backgroundColor = .lightGray
        view.addSubview(collectionViewTemp)
        
        return collectionViewTemp
    }()
    
    private var sections: [BaseCollectionSectionProtocol] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    func displaySections(sections: [BaseCollectionSectionProtocol]) {
        self.sections = sections
        collectionView.reloadData()
    }
    
    func updateSection(sectionIndex: Int, section: BaseCollectionSectionProtocol) {
        if sectionIndex < sections.count {
            self.sections[sectionIndex] = section
            collectionView.reloadData()
        }
    }
    
    func updateEndOfCollection() {
        isUpdatingBottom = false
    }
    
}

extension BaseCollectionViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = sections[indexPath.section]
        
        if !collectionView.registeredClasses.keys.contains(section.reuseIdentifierDefined) {
            collectionView.register(section.cellType, forCellWithReuseIdentifier: section.reuseIdentifierDefined)
        }
        
        guard let cell = sections[indexPath.section].getCell(at: indexPath,collectionView: collectionView) as? UICollectionViewCell else { return .init() }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return sections[indexPath.section].cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if !isUpdatingBottom, indexPath.section == sections.count - 1, indexPath.item > sections[indexPath.section].numberOfItems - 5 {
            isUpdatingBottom = true
            updateEndOfCollection()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        sections[indexPath.section].didSelect(at: indexPath.item)
    }
    
}

extension BaseCollectionViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].numberOfItems
    }
}
