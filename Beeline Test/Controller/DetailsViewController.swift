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
    
    // MARK: - Variables -
    
    public var imageCollection = ImageView()
    
    public var product: ProductData? {
        didSet {
            setProducts()
        }
    }
    
    private lazy var priceWDiscountLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = Fonts.interSemiBold175
        label.textColor = Colors.red
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = Fonts.interMedium175
        label.attributedText = Constant.AttributedText.attributedText
        label.textColor = .gray
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = Fonts.interMedium16
        label.textAlignment = .left
        return label
    }()
    
    private lazy var starImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "star")
        return image
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = Fonts.interMedium14
        label.textColor = .darkGray
        label.textAlignment = .left
        return label
    }()
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = Fonts.interMedium16
        label.textColor = .darkGray
        label.textAlignment = .left
        return label
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = Fonts.interMedium16
        label.textAlignment = .left
        return label
    }()
    
    private lazy var buyNowButton: UIButton = {
        let button = UIButton()
        button.setTitle("Buy Now", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Colors.red
        button.layer.cornerRadius = 10
        return button
    }()
    
    private lazy var addToCartButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add To Cart", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 10
        return button
    }()
    
    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
    }
    
    // MARK: - Actions -
    
    public func calculatePercentage(value: Double, percentageVal: Double) -> Double {
        let val = value - (value * (percentageVal/100))
        return val
    }
    
    // MARK: - Setup -
    
    private func setProducts() {
        guard let product = product else { return }
        titleLabel.text = product.title
        let price = calculatePercentage(value: product.price, percentageVal: product.discountPercentage)
        priceWDiscountLabel.text = "$\(price.roundToPlaces(places: 2))"
        priceLabel.text = "$\(product.price.roundToPlaces(places: 2))"
        ratingLabel.text = "\(product.rating)"
        descriptionLabel.text = product.description
        imageCollection.items = product.images
    }
    
    private func setupViews(){
        [imageCollection, titleLabel, starImage, descriptionLabel, priceWDiscountLabel, priceLabel, ratingLabel, categoryLabel, buyNowButton, addToCartButton].forEach{
            view.addSubview($0)
        }
    }
    
    private func setupConstraints(){
        imageCollection.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.left.right.equalToSuperview()
        }
        priceWDiscountLabel.snp.makeConstraints {
            $0.top.equalTo(imageCollection.snp.bottom).offset(10)
            $0.left.equalToSuperview().offset(20)
        }
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(imageCollection.snp.bottom).offset(10)
//            $0.left.equalTo(priceWDiscountLabel.snp.right).offset(10)
            $0.right.equalToSuperview().inset(20)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(priceWDiscountLabel.snp.bottom).offset(10)
            $0.left.equalToSuperview().inset(20)
        }
        starImage.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.left.equalToSuperview().inset(20)
            $0.size.equalTo(15)
        }
        ratingLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.left.equalTo(starImage.snp.right).offset(5)
        }
        categoryLabel.snp.makeConstraints {
            $0.top.equalTo(starImage.snp.bottom).offset(10)
            $0.left.equalToSuperview().inset(20)
        }
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(categoryLabel.snp.bottom).offset(10)
            $0.left.right.equalToSuperview().inset(20)
        }
        buyNowButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(50)
            $0.left.equalToSuperview().offset(20)
            $0.width.equalTo(180)
            $0.height.equalTo(50)
        }
        addToCartButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(50)
            $0.right.equalToSuperview().inset(20)
            $0.width.equalTo(180)
            $0.height.equalTo(50)
        }
    }
}

