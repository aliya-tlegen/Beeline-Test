//
//  MainPageCollectionViewCell.swift
//  Beeline Test
//
//  Created by Алия Тлеген on 10.11.2022.
//

import UIKit

class MainPageCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MainPageCollectionViewCell"
    
    // MARK: - Private variables -
    
    private lazy var sectionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .clear
        button.isUserInteractionEnabled = false
        return button
    }()

    // MARK: - Initialization -

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        clipsToBounds = true
        layer.cornerRadius = 15
        layer.borderWidth = 1
    }
    
    func configureCell(title: String?, isSelected: Bool) {
        sectionButton.setTitle(title, for: .normal)
        sectionButton.setTitleColor(isSelected ? .blue : .black, for: .normal)
//        layer.borderColor = isSelected ? Colors.green.cgColor : Colors.borderColor.cgColor
    }
    
    // MARK: - Setup -
    
    private func setupViews() {
        contentView.addSubview(sectionButton)
        setupConstraints()
    }
    
    func setupConstraints() {
        sectionButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(7)
            $0.right.left.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
    }
}
