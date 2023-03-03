//
//  MountainsViewController.swift
//  DiffableDataSourceSample
//
//  Created by jiwon Yoon on 2023/03/03.
//

import UIKit
import SnapKit

class MountainsViewController: UIViewController {
    private lazy var mountainsCollectionView: UICollectionView = {
        let layout = createLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    private var mountainsController = MountainsController()
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, MountainsController.Mountain>!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
        setupViews()
        configureDataSource()
        performQuery(with: nil)
    }


}

private extension MountainsViewController {
    func setupViews() {
        view.addSubview(mountainsCollectionView)
        
        mountainsCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    
    func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<LabelCell, MountainsController.Mountain> {cell,indexPath,itemIdentifier in
            cell.setLabelTitle(title: itemIdentifier.name)
        }
        
        
        dataSource = UICollectionViewDiffableDataSource<Section, MountainsController.Mountain>(collectionView: mountainsCollectionView) { collectionView,indexPath,itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
    }
    
    func performQuery(with filter: String?) {
        let mountains = mountainsController.filteredMountains(with: filter).sorted { $0.name < $1.name }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, MountainsController.Mountain>()
        snapshot.appendSections([.main])
        snapshot.appendItems(mountains)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex , layoutEnvironment) -> NSCollectionLayoutSection in
            let contentSize = layoutEnvironment.container.effectiveContentSize
            let columns = contentSize.width > 800 ? 3 : 2
            let spacing = CGFloat(10)
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(32))
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columns)
            group.interItemSpacing = .fixed(spacing)
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = spacing
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            
            return section
        }
        
        return layout
    }
}


enum Section: CaseIterable {
    case main
}

struct Mountain: Hashable {
    let name: String
    let height: Int
    let identifier = UUID()
}
