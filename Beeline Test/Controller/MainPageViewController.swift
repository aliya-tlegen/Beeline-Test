//
//  ViewController.swift
//  Beeline Test
//
//  Created by Алия Тлеген on 09.11.2022.
//

import UIKit
import SnapKit
import Moya

class MainPageViewController: UIViewController {
    
    // MARK: - Public variables -
    
    public var items: Product?
    let networkProvider = MoyaProvider<NetworkService>()
    private let mainPageViewModel: MainPageViewModel?

    
    init(mainPageViewModel: MainPageViewModel){
        self.mainPageViewModel = mainPageViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func fetchData(){
        mainPageViewModel?.fetchProducts()
    }
    
    // MARK: - Private variables -
    
    private var index: Int = 0

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewLayout()
        )
        collectionView.isUserInteractionEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionView.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.register(MainPageCollectionViewCell.self, forCellWithReuseIdentifier: MainPageCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Online Store"
        view.backgroundColor = .white
        mainPageViewModel?.delegate = self
        setupViews()
        setupConstraints()
        fetchData()
    }
    
    // MARK: - Setup -
    
    private func setupViews() {
        view.addSubview(collectionView)
//        collectionView.addSubview(stackView)
    }
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: - Actions -
    
}

extension MainPageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let items = items?.productData {
            return items.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let items = items?.productData[indexPath.row] {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainPageCollectionViewCell.identifier, for: indexPath) as? MainPageCollectionViewCell {
                cell.configure(model: items)
                return cell
                }
            }
            return UICollectionViewCell()
        }
}

extension MainPageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 300)
    }
}

extension MainPageViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainPageViewController: MainPageViewModelProtocol {
    func loadProducts() {
        self.items = mainPageViewModel?.productsModel
        self.collectionView.reloadData()
    }
}

