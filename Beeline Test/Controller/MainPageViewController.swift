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
    
    // MARK: - Variables -
    
    public var items: Product?
    public var filteredItems: [ProductData?] = []
    
    let networkProvider = MoyaProvider<NetworkService>()
    private let mainPageViewModel: MainPageViewModel?
    
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }

    var searchController: UISearchController!
    
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
    
    private var index: Int = 0

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewLayout()
        )
        collectionView.isUserInteractionEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
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
        
        view.backgroundColor = .white
        mainPageViewModel?.delegate = self
        setupViews()
        setupConstraints()
        setupNavigationItem()
        setupSearchController()
        fetchData()
    }
    
    
    
    // MARK: - Setup -
    
    private func setupViews() {
        view.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupNavigationItem(){
        navigationItem.title = "Online Store"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .search,
            target: self,
            action:#selector(didTapSearch)
        )
    }
    
    func setupSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.sizeToFit()
        definesPresentationContext = true
    }
    
    // MARK: - Actions -
    
    @objc private func didTapSearch(){
        showSearchView()
    }
    
    func showSearchView(){
        searchController.searchBar.alpha = 0
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.titleView = searchController.searchBar
        navigationItem.setRightBarButton(nil, animated: true)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.searchController.searchBar.alpha = 1
          }, completion: { finished in
              self.searchController.searchBar.becomeFirstResponder()
        })
    }
    
    func hideSearchView(){
        navigationItem.setRightBarButton(navigationItem.rightBarButtonItem, animated: true)
        navigationItem.titleView?.alpha = 0
        
        UIView.animate(withDuration: 0.3, animations: {
            self.searchController.searchBar.alpha = 0
            self.navigationItem.titleView?.alpha = 1
             }, completion: { finished in
                 self.searchController.searchBar.resignFirstResponder()
           })
    }
    
    func filterContentForSearchText(_ searchText: String) {
        if let items = items?.productData {
            filteredItems = items.filter { (item: ProductData) -> Bool in
                let category = item.category.lowercased().contains(searchText.lowercased())
                let title = item.title.lowercased().contains(searchText.lowercased())
                let brand = item.brand.lowercased().contains(searchText.lowercased())
                return category || title || brand
            }
            collectionView.reloadData()
        }
    }
}

// MARK: - CollectionViews Extensions -

extension MainPageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltering {
            return filteredItems.count
        }
        if let items = items?.productData {
            return items.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainPageCollectionViewCell.identifier, for: indexPath) as! MainPageCollectionViewCell
        if isFiltering {
            cell.configure(model: filteredItems[indexPath.row]!)
        } else {
            cell.configure(model: (items?.productData[indexPath.row])!)
        }
        return cell
    }
}

extension MainPageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = 200
        let height = 300
        return CGSize(width: width, height: height)
    }
}

extension MainPageViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailsViewController()
        if let items = items?.productData[indexPath.row] {
            if isFiltering {
                vc.product = filteredItems[indexPath.row]
            } else {
                vc.product = items
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainPageViewController: MainPageViewModelProtocol {
    func loadProducts() {
        self.items = mainPageViewModel?.productsModel
        self.collectionView.reloadData()
    }
}

// MARK: - UISearch & UISearchController Extensions -

extension MainPageViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
}

extension MainPageViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.searchBar.alpha = 0
        setupNavigationItem()
    }
}
