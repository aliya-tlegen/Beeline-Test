//
//  DetailsViewController.swift
//  Beeline Test
//
//  Created by Алия Тлеген on 09.11.2022.
//

import UIKit
import Kingfisher

protocol ActionDelegate {
    func didTapBanner(index: Int)
}

class DetailsViewController: UIViewController {
    
    // MARK: - Private variables -
    
    public var imageCollection = ImageView()
    
    public var product: ProductData? {
        didSet {
            setProducts()
        }
    }
    
    private func setProducts() {
        guard let product = product else { return }
        titleLabel.text = product.title
        categoryLabel.text = product.category
        priceLabel.text = "$\(product.price)"
        ratingLabel.text = "$\(product.rating)"
        imageCollection.items = product.images
    }
        
//        if let products = products, !products.isEmpty {
//            imageCollection.items = product
//        } else {
//            imageCollection.items = [Banner(bannerImage: restaurant.restaurantImage, bannerTitle: "")]
//        }
    
    // MARK: - Public variables -

    
    
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
        label.numberOfLines = 0
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
    
    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
    }
    
    // MARK: - Initialization -
    
    private func setupViews(){
        view.addSubview(imageCollection)
        view.addSubview(titleLabel)
        view.addSubview(priceLabel)
        view.addSubview(ratingLabel)
        view.addSubview(categoryLabel)
    }
    
    // MARK: - Setup -
    
    private func setupConstraints(){
        imageCollection.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview().inset(20)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageCollection.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
//            $0.left.equalToSuperview().inset(20)
        }
        categoryLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
//            $0.left.equalToSuperview().inset(20)
        }
    }
}

// MARK: - Extensions -



    // MARK: - Setup -
    
    
    
    // MARK: - Actions -

