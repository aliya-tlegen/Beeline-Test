//
//  MainPageTableViewCell.swift
//  Beeline Test
//
//  Created by Алия Тлеген on 09.11.2022.
//

import UIKit

class MainPageCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Public variables -
    
    static let identifier = "MainPageTableViewCell"
    
    // MARK: - Private variables -
    
    private lazy var label: UILabel = {
       let label = UILabel()
        return label
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
        containerView.addSubview(label)
    }
    
    private func setupConstraints() {
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
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
        label.text = model.title
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
