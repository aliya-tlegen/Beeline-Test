//
//  MainPageTableViewCell.swift
//  Beeline Test
//
//  Created by Алия Тлеген on 09.11.2022.
//

import UIKit
import Kingfisher

class MainPageCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Public variables -
    
    static let identifier = "MainPageTableViewCell"
    
    // MARK: - Private variables -
    
    private lazy var productTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private lazy var thumbnail: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        return image
    }()
    
    public var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .yellow
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 10
        return containerView
    }()
    
    // MARK: - Lifecycle -
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup -
    
    private func setupViews() {
        contentView.addSubview(containerView)
        containerView.addSubview(productTitle)
        containerView.addSubview(thumbnail)
    }
    
    private func setupConstraints() {
        thumbnail.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(5)
//            $0.left.right.equalToSuperview().offset(5)
            $0.width.equalTo(200)
            $0.height.equalTo(200)
        }
        productTitle.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.top.equalTo(thumbnail.snp.bottom)
            $0.left.right.equalToSuperview().inset(5)
        }
        containerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.right.left.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Configuration -
    
    func configure(model: ProductData) {
        productTitle.text = model.title
        if let image = model.thumbnail {
            let source = ImageResource(downloadURL: URL(string: model.thumbnail ?? "")!)
            thumbnail.kf.setImage(with: source)
        }
    }

//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    

}
