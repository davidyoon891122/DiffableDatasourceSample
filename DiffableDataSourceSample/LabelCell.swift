//
//  LabelCell.swift
//  DiffableDataSourceSample
//
//  Created by jiwon Yoon on 2023/03/03.
//

import UIKit

final class LabelCell: UICollectionViewCell {
    static let identifier = "LabelCell"
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLabelTitle(title: String) {
        label.text = title
    }
}

private extension LabelCell {
    func setupViews() {
        contentView.addSubview(label)
        label.layer.borderWidth = 1.0
        label.layer.borderColor = UIColor.systemGray2.cgColor
        
        
        label.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10.0)
            $0.trailing.equalToSuperview().offset(-10.0)
            $0.centerY.equalToSuperview()
        }
        
    }
}
