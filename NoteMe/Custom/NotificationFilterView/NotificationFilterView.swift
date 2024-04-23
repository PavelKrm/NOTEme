//
//  NotificationFilterView.swift
//  NoteMe
//
//  Created by PavelKrm on 12.04.24.
//

import UIKit
import SnapKit

enum FilterType: CaseIterable {
    
    case all
    case date
    case location
    case timer
    
    var title: String {
        switch self {
            
        case .all:  return L10n.all
        case .date: return L10n.date
        case .timer: return L10n.timer
        case .location: return L10n.location
        }
    }
}

protocol NotificationFilterViewDelegate: AnyObject {
    
    func notificationFilterView(_ filterView: NotificationFilterView,
                                didSelect type: FilterType)
}

final class NotificationFilterView: UIView {
    
    private enum Const {
        static let minimumLineSpacing: CGFloat = 8.0
        static let horisontalInset: CGFloat = 20.0
        static let contentHeight: CGFloat = 32.0
        static let minimumItemWidth: CGFloat = 51.0
        static let titlePadding: CGFloat = 8.0
    }
    
    private lazy var layout: UICollectionViewLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = Const.minimumLineSpacing
        layout.sectionInset = UIEdgeInsets(top: .zero,
                                           left: Const.horisontalInset,
                                           bottom: .zero,
                                           right: Const.horisontalInset)
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero,
                                           collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.register(NotificationFilterCell.self)
        collection.dataSource = self
        collection.delegate = self
        
        return collection
    }()
    
    weak var delegate: NotificationFilterViewDelegate?
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .clear
        addSubview(collectionView)
        
        collectionView.selectItem(at: .init(row: .zero, section: .zero),
                                  animated: false,
                                  scrollPosition: .left)
    }
    
    private func setupConstraints() {
        
        collectionView.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
    }
    
}

//MARK: - UICollectionViewDataSource

extension NotificationFilterView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return FilterType.allCases.count
    }
    
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell: NotificationFilterCell = collectionView.dequeue(at: indexPath)
        cell.configure(with: .allCases[indexPath.row])
        return cell
    }
}

//MARK: - UICollectionViewDelegate

extension NotificationFilterView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        delegate?.notificationFilterView(
            self,
            didSelect: FilterType.allCases[indexPath.row]
        )
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension NotificationFilterView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let titleType = FilterType.allCases[indexPath.row].title
        let calculatedWidth = titleType.mimimumWidthToDisplay(
            font: .appFont.withSize(17.0),
            height: Const.contentHeight
        ) + Const.titlePadding * 2
        
        let width = calculatedWidth < Const.minimumItemWidth
        ? Const.minimumItemWidth : calculatedWidth
        
        return CGSize(width: width, height: Const.contentHeight)
        
    }
}

//MARK: - L10n

extension FilterType {
    
    private enum L10n {
        
        static let all = "FilterType_all_title".localized
        static let date = "FilterType_date_title".localized
        static let timer = "FilterType_timer_title".localized
        static let location = "FilterType_location_title".localized
    }
}
