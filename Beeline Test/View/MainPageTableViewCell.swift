//
//  MainPageTableViewCell.swift
//  Beeline Test
//
//  Created by Алия Тлеген on 09.11.2022.
//

import UIKit

class MainPageTableViewCell: UITableViewCell {
    
    // MARK: - Public variables -
    
    static let identifier = "MainPageTableViewCell"
    
    // MARK: - Private variables -
    
    private lazy var label: UILabel = {
       let label = UILabel()
        return label
    }()
    
    public var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .blue
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 10
        return containerView
    }()
    
    // MARK: - Lifecycle -
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .clear
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
            $0.top.equalToSuperview().offset(5)
        }
        containerView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(4)
            $0.centerX.equalToSuperview()
            $0.right.left.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
    }
    
    // MARK: - Configuration -
    
    func configure(model: Product) {
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
