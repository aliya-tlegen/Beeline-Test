//
//  ViewController.swift
//  Beeline Test
//
//  Created by Алия Тлеген on 09.11.2022.
//

import UIKit
import SnapKit

class MainPageViewController: UIViewController {
    
    // MARK: - Public variables -
    
    public var items = [Product(id: 1, title: "Товар 1", description: "описание", price: 324, discountPercentage: 12.5, rating: 4.5, stock: 23, brand: "", category: "category", thumbnail: "", images: [""]),
                        Product(id: 2, title: "Товар 2", description: "описание", price: 0, discountPercentage: 2.0, rating: 2.3, stock: 32, brand: "", category: "category 1", thumbnail: "", images: [""])]

    // MARK: - Private variables -
    
    private var index: Int = 0
    
//    private lazy var collectionView: UICollectionView = {
//        let flowLayout = UICollectionViewFlowLayout()
//        flowLayout.minimumLineSpacing = 10
//        flowLayout.scrollDirection = .horizontal
//
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
////        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
//        collectionView.dataSource = self
//        collectionView.delegate = self
//        collectionView.isPagingEnabled = true
//        collectionView.backgroundColor = .blue
//        collectionView.showsHorizontalScrollIndicator = false
//        collectionView.showsVerticalScrollIndicator = false
//        collectionView.register(MainPageCollectionViewCell.self, forCellWithReuseIdentifier: MainPageCollectionViewCell.identifier)
//        return collectionView
//    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .green
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = true
        tableView.separatorStyle = .singleLine
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorStyle = .singleLine
        tableView.register(MainPageTableViewCell.self, forCellReuseIdentifier: "MainPageTableViewCell")
        tableView.rowHeight = 200
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 70, right: 0)
        return tableView
    }()
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Smartphone Shop"
//        navigationController?.navigationBar.tintColor = .black
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Setup -
    
    private func setupViews() {
//        view.addSubview(collectionView)
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
//        collectionView.snp.makeConstraints {
//            $0.top.equalToSuperview()
//            $0.left.equalToSuperview().offset(20)
//            $0.height.equalTo(20)
//        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(10)
            $0.left.right.equalToSuperview().inset(20)
        }
    }
    
    
    // MARK: - Actions -
    
    
}

// MARK: - UICollectionView Extensions -

//extension MainPageViewController: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return items.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = items[indexPath.row].category.width(withConstrainedHeight: 28, font: .systemFont(ofSize: 14))
//
//        return CGSize(width: (width ) + 20, height: 28)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainPageCollectionViewCell.identifier, for: indexPath) as? MainPageCollectionViewCell
//        cell?.configureCell(title: items[indexPath.row].category, isSelected: indexPath.row == index)
//        return cell ?? MainPageCollectionViewCell()
//    }
//
//
//}

//extension MainPageViewController: UICollectionViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        index = indexPath.row
//        self.tableView.scrollToRow(at: IndexPath(row: 0, section: indexPath.row), at: .top, animated: true)
//        self.collectionView.reloadSections(IndexSet(integer: 0))
//    }
//}


// MARK: - UITableView Extensions -

extension MainPageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: MainPageTableViewCell.identifier, for: indexPath) as! MainPageTableViewCell
        cell.configure(model: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainPageTableViewCell.identifier, for: indexPath) as! MainPageTableViewCell

    }
    
}

extension MainPageViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        //
//    }
}
