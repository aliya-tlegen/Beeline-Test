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
    
    private lazy var thumbnailImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
//        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private lazy var starImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "star")
        return image
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
//    public var containerView: UIView = {
//        let containerView = UIView()
//        containerView.backgroundColor = .yellow
//        containerView.clipsToBounds = true
//        containerView.layer.cornerRadius = 10
//        return containerView
//    }()
    
    // MARK: - Lifecycle -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // MARK: - Setup -
    
    private func setupViews() {
//        contentView.addSubview(containerView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(thumbnailImage)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(starImage)
        contentView.addSubview(ratingLabel)
    }
    
    private func setupConstraints() {
        thumbnailImage.snp.makeConstraints {
//            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview().inset(5)
            $0.width.equalTo(200)
            $0.height.equalTo(190)
        }
        titleLabel.snp.makeConstraints {
//            $0.center.equalToSuperview()
            $0.top.equalTo(thumbnailImage.snp.bottom).offset(5)
            $0.left.right.equalToSuperview().inset(10)
            $0.width.equalTo(170)
        }
        categoryLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.left.right.equalToSuperview().inset(10)
        }
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(categoryLabel.snp.bottom).offset(5)
            $0.left.right.equalToSuperview().inset(10)
        }
        starImage.snp.makeConstraints {
            $0.top.equalTo(priceLabel.snp.bottom).offset(5)
            $0.left.equalToSuperview().offset(10)
            $0.size.equalTo(15)
        }
        ratingLabel.snp.makeConstraints {
            $0.top.equalTo(priceLabel.snp.bottom).offset(5)
            $0.left.equalTo(starImage.snp.right).offset(5)
        }
//        containerView.snp.makeConstraints {
//            $0.top.equalToSuperview()
//            $0.centerX.equalToSuperview()
//            $0.right.left.equalToSuperview()
//            $0.bottom.equalToSuperview()
//        }
    }
    
    // MARK: - Configuration -
    
    func configure(model: ProductData) {
        titleLabel.text = model.title
        if let image = model.thumbnail {
            let source = ImageResource(downloadURL: URL(string: model.thumbnail ?? "")!)
            thumbnailImage.kf.setImage(with: source)
        }
        categoryLabel.text = model.category
        priceLabel.text = "$\(model.price)"
        ratingLabel.text = "\(model.rating)"
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
