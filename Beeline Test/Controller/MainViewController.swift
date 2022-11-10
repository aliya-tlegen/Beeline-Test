//
//  MainViewController.swift
//  Beeline Test
//
//  Created by Алия Тлеген on 10.11.2022.
//

import UIKit
//import Moya

class MainViewController: UIViewController {
    
    // MARK: - Public Variables -
    
    public var items = [Product(id: 1, title: "Товар 1", description: "описание", price: 324, discountPercentage: 12.5, rating: 4.5, stock: 23, brand: "", category: "category", thumbnail: "", images: [""]),
                        Product(id: 2, title: "Товар 2", description: "описание", price: 0, discountPercentage: 2.0, rating: 2.3, stock: 32, brand: "", category: "category 1", thumbnail: "", images: [""])]
    
    //    public var items = [MenuFoodCategory]()
    //    public var filteredItems: [MenuFoodCategory] = []
    
    // MARK: - Private Variables -
    
    //    var isSearchBarEmpty: Bool {
    //      return searchController.searchBar.text?.isEmpty ?? true
    //    }
    //
    //    var isFiltering: Bool {
    //        return searchController.isActive && !isSearchBarEmpty
    //    }
    //
    //    private var searchController: UISearchController!
    
    //    let browseProvider = MoyaProvider<BrowseService>()
    //    private let menuViewModel: MenuPageViewModel
    //    private let menuSearchViewModel: MenuSearchViewModel
    
    private var index: Int = 0
    
    var selectedIndex: IndexPath?
    
    private var totalPrice: Int = 0
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 10
        flowLayout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(MainPageCollectionViewCell.self, forCellWithReuseIdentifier: MainPageCollectionViewCell.identifier)
        return collectionView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = true
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.register(MainPageTableViewCell.self, forCellReuseIdentifier: MainPageTableViewCell.identifier)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 70, right: 0)
        return tableView
    }()
    
    
    private let orderLabel: UILabel = {
        let label = UILabel()
        label.text = "Ваш заказ 1"
        label.textColor = .white
        //        label.font = .interSemiBold16
        return label
    }()
    
    public let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        //        label.font = Fonts.interSemiBold16
        return label
    }()
    
    private let  payButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .green
        btn.layer.cornerRadius = 10
        //        btn.addTarget(self, action: #selector(touchBtn), for: .touchUpInside)
        btn.isHidden = true
        return btn
    }()
    
    //    private let notFoundLabel: UILabel = {
    //        let label = UILabel()
    //        label.textColor = Colors.darkGray3
    //        label.font = Fonts.interRegular12
    //        label.text = """
    //        К сожалению, по вашему запросу
    //        ничего не найдено
    //        """
    //        label.textAlignment = .center
    //        label.isHidden = true
    //        return label
    //    }()
    
    // MARK: - Initialization -
    
    //    init(menuPageViewModel: MenuPageViewModel, menuSearchViewModel: MenuSearchViewModel) {
    //        self.menuViewModel = menuPageViewModel
    //        self.menuSearchViewModel = menuSearchViewModel
    //        super.init(nibName: nil, bundle: nil)
    //    }
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        //        configureSearchController()
        setupConstraints()
        setupNavigationItem()
        //        fetchData()
    }
    
    // MARK: - Setup -
    
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        view.addSubview(tableView)
        view.addSubview(payButton)
        //        tableView.addSubview(notFoundLabel)
        //        tableView.bringSubviewToFront(notFoundLabel)
        payButton.addSubview(orderLabel)
        payButton.addSubview(priceLabel)
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.right.left.equalToSuperview().inset(20)
            $0.height.equalTo(28)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(12)
            $0.right.left.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().offset(-16)
        }
        
        payButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-120)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
            $0.left.right.equalToSuperview().inset(20)
        }
        
        orderLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().inset(20)
        }
        
        priceLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().inset(20)
        }
        
        //        notFoundLabel.snp.makeConstraints {
        //            $0.left.right.equalToSuperview().inset(87)
        //            $0.top.equalToSuperview().offset(106)
        //        }
    }
    
    private func setupNavigationItem(){
        navigationItem.title = "Store"
        navigationController?.navigationBar.tintColor = .black
        //        navigationItem.rightBarButtonItem = UIBarButtonItem(
        //            barButtonSystemItem: .search,
        //            target: self,
        //            action:#selector(didTapSearch)
        //        )
    }
    
    //    func configureSearchController() {
    //        searchController = UISearchController(searchResultsController: nil)
    //        searchController.obscuresBackgroundDuringPresentation = false
    ////        searchController.searchBar.delegate = self
    //        searchController.searchResultsUpdater = self
    //        searchController.searchBar.delegate = self
    //        searchController.hidesNavigationBarDuringPresentation = false
    //        searchController.searchBar.sizeToFit()
    //        definesPresentationContext = true
    //    }
    
    // MARK: - Actions -
    
    func reloadCollectionView() {
        self.collectionView.reloadSections(IndexSet(integer: 0))
    }
    
    func reloadTableView() {
        self.tableView.reloadData()
    }
    
    private func configureNavBar() {
        let rightIcon = UIImage(systemName: "magnifyingglass")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: rightIcon, style: .plain, target: self, action: nil)
        navigationController?.navigationBar.tintColor = UIColor.label
        
        let leftIcon = UIImage(systemName: "chevron.backward")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: leftIcon, style: .plain, target: self, action: #selector(popPerehod))
        
        navigationController?.navigationBar.tintColor = .black
    }
    
    @objc private func popPerehod() {
        navigationController?.popViewController(animated: true)
    }
    
    //    @objc private func touchBtn(){
    //        callback?(priceLabel.text!)
    //        let basketVC = BasketViewController()
    //        basketVC.basket = self.basket
    //        navigationController?.pushViewController(basketVC, animated: true)
    //    }
    
    //    func fetchData() {
    //        menuViewModel.fetchMenu()
    //        menuViewModel.delegate = self
    //    }
    
    //    @objc private func didTapSearch(){
    //        showSearchView()
    //    }
    
    //    func showSearchView(){
    //        searchController.searchBar.alpha = 0
    //        searchController.searchBar.placeholder = "Поиск"
    //        navigationItem.titleView = searchController.searchBar
    //        navigationItem.setRightBarButton(nil, animated: true)
    //
    //        UIView.animate(withDuration: 0.5, animations: {
    //            self.searchController.searchBar.alpha = 1
    //          }, completion: { finished in
    //              self.searchController.searchBar.becomeFirstResponder()
    //        })
    //    }
    //
    //    func hideSearchView(){
    //        navigationItem.setRightBarButton(navigationItem.rightBarButtonItem, animated: true)
    //        navigationItem.titleView?.alpha = 0
    //
    //        UIView.animate(withDuration: 0.3, animations: {
    //            self.searchController.searchBar.alpha = 0
    //            self.navigationItem.titleView?.alpha = 1
    //             }, completion: { finished in
    //                 self.searchController.searchBar.resignFirstResponder()
    //           })
    //    }
    
    //    func filterContentForSearchText(_ searchText: String) {
    //        let item: MenuFoodCategory
    //        filteredItems = items.filter { (item) -> Bool in
    //            let categoryName = item.name!.lowercased().contains(searchText.lowercased())
    //            let dishTitle = item.productSet!.contains(where: { $0.title!.contains(searchText.lowercased()) })
    //            let dishDescription = item.productSet!.contains(where: { $0.description!.contains(searchText.lowercased()) })
    //
    //            return categoryName || dishTitle || dishDescription
    //        }
    //      tableView.reloadData()
    //    }
}

// MARK: - CollectionView Extensions -

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if isFiltering {
//            return filteredItems.count
//        }
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainPageCollectionViewCell.identifier, for: indexPath) as? MainPageCollectionViewCell
//        if isFiltering {
//            cell?.configureCell(title: filteredItems[indexPath.row].name, isSelected: indexPath.row == index)
//        } else {
        cell?.configureCell(title: items[indexPath.row].category, isSelected: indexPath.row == index)
//        }
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = items[indexPath.row].category.width(withConstrainedHeight: 28, font: .systemFont(ofSize: 14))
        
        return CGSize(width: (width ?? 0) + 20, height: 28)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        index = indexPath.row
        self.tableView.scrollToRow(at: IndexPath(row: 0, section: indexPath.row), at: .top, animated: true)
        reloadCollectionView()
    }
}

// MARK: - TableView Extensions -

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
//        if isFiltering {
//            return filteredItems.count
//        }
        return items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.cellForRow(at: indexPath) as? MainPageTableViewCell
//        tableView.beginUpdates()
//        items[indexPath.section].productSet?[indexPath.row].isSelected.toggle()
//        cell?.selected(value: items[indexPath.section].productSet?[indexPath.row].isSelected ?? true)
//        tableView.endUpdates()
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if isFiltering {
//            return filteredItems[section].productSet?.count ?? 0
//        }
//        return items[section].productSet?.count ?? 0
//        return items[section].category.count ?? 0
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: MainPageTableViewCell.identifier, for: indexPath) as? MainPageTableViewCell
//        var count =
//        if let index = basket.firstIndex(where: { $0.title == model?.title }),
//            let newCount = basket[index].count {
//            count = newCount
//        }
//        cell?.configureCell(object: model, count: count)
//        if isFiltering {
//            cell?.configureCell(object: filteredItems[indexPath.section].productSet?[indexPath.row], count: count)
//            cell!.titleLabel.setHighlighted(cell!.titleLabel.text!, with: searchController.searchBar.text!)
//            cell!.descriptionLabel.setHighlighted(cell!.descriptionLabel.text!, with: searchController.searchBar.text!)
//        } else {
//            cell?.configureCell(object: items[indexPath.section].productSet?[indexPath.row], count: count)
        cell?.configure(model: model)
//        }
//        cell?.delegate = self
        return cell!
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let titleLabel = UILabel()

//        if isFiltering {
//            titleLabel.text = filteredItems[section].name
//        } else {
            titleLabel.text = items[section].category
//        }
//        titleLabel.font = Fonts.interBold24
//        titleLabel.textColor = Colors.text
        titleLabel.textAlignment = .left

        headerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        return headerView
    }
    
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        let cell = tableView.cellForRow(at: indexPath) as? MainPageTableViewCell
//        items[indexPath.section].productSet?[indexPath.row].isSelected = false
//        tableView.beginUpdates()
//        cell?.selected(value: false)
//        tableView.endUpdates()
//    }
}

// MARK: - StepperView Extension -

//extension MenuVC: StepperViewDelegate {
//    func isCountChanged(count: Int, model: DishData?) {
//        if var model = model {
//            if let index = basket.firstIndex(where: { $0.title == model.title }) {
//                basket[index].count = count
//            } else {
//                model.count = count
//                basket.append(model)
//            }
//            var total = 0
//            for element in basket {
//                total += (element.price ?? 0) * (element.count ?? 0)
//            }
//            if total == 0 {
//                payButton.isHidden = true
//            } else {
//                priceLabel.text = "\(total)₸"
//                payButton.isHidden = false
//            }
//        }
//    }
//}

// MARK: - ViewModel Extension -

//extension MenuVC: MenuPageViewModelProtocol {
//    func loadMenu() {
//        self.items = menuViewModel.menuModel
//        self.collectionView.reloadData()
//        self.tableView.reloadData()
//    }
//}

//extension MenuVC: MenuSearchViewModelProtocol {
//    func loadMenuSearch() {
//        self.filteredItems = menuSearchViewModel.menuModel
//        self.tableView.reloadData()
//    }
//}

// MARK: - UISearchController Extension -

//extension MenuVC: UISearchResultsUpdating {
//    func updateSearchResults(for searchController: UISearchController) {
//        if let text = searchController.searchBar.text {
//            filterContentForSearchText(text)
////            menuSearchViewModel.fetchMenuItem(searchWord: text)
//        }
//
////        menuSearchViewModel.delegate = self
//    }
//}

// MARK: - UISearchBar Extension -

//extension MenuVC: UISearchBarDelegate {
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        searchController.searchBar.alpha = 0
////        hideSearchView()
//        setupNavigationItem()
//    }
//
//}


