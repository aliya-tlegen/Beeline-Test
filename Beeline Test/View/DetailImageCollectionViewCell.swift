//
//  DetailImageCollectionViewCell.swift
//  Beeline Test
//
//  Created by Алия Тлеген on 11.11.2022.
//

import UIKit
import Kingfisher

class DetailImageCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Variables -
    
    static let identifier = "DetailImageCollectionViewCell"
    
    public var isHideActionButton = false
    
    public var thumbnailImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = false
        return imageView
    }()
    
    // MARK: - Initialization -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
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
}
