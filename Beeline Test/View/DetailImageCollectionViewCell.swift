//
//  DetailImageCollectionViewCell.swift
//  Beeline Test
//
//  Created by Алия Тлеген on 11.11.2022.
//

import UIKit
import Kingfisher

class DetailImageCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "DetailImageCollectionViewCell"
    
    public var isHideActionButton = false
    
    public var thumbnailImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    // MARK: - Initialization -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBackground
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
            fatalError()
        }
    
    override func layoutSubviews() {
            super.layoutSubviews()
        }
    
    // MARK: - Setup -
    
    private func setupViews(){
        contentView.addSubview(thumbnailImage)
    }
    
    private func setupConstraints(){
        thumbnailImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    @objc func showDiscountVC(){
        print("akcciiiii vc")
    }
    
    // MARK: - ? -
    
    override func prepareForReuse() {
          super.prepareForReuse()
      }
    
    // MARK: - Configuration -
    
    public func configure(with items: ProductData) {
        let images = items.images.map {
            let source = ImageResource(downloadURL: URL(string: $0.self)!)
            thumbnailImage.kf.setImage(with: source)
        }
    }
}
