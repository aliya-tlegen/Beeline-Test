//
//  ImageView.swift
//  Beeline Test
//
//  Created by Алия Тлеген on 11.11.2022.
//

import UIKit
import Kingfisher

class ImageView: UIView {
    
    // MARK: - Public variables -
//    var delegate: ActionDelegate?
    var currentPage = 0
    
    {
        didSet{
            pageController.currentPage = currentPage
        }
    }
    
    
    var isHideActionButton = false
    {
        didSet{
            self.collectionView.reloadData()
        }
    }
    
    public lazy var items = [String]()
    {
        didSet{
            pageController.numberOfPages = items.count
            self.collectionView.reloadData()
        }
    
    }
    
    // MARK: - Private variables -
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
                    frame: .zero,
                   collectionViewLayout: UICollectionViewLayout()
               )

        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionView.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        collectionViewFlowLayout.scrollDirection = .horizontal
        collectionViewFlowLayout.minimumLineSpacing = 0
        collectionViewFlowLayout.minimumInteritemSpacing = 0
        collectionView.register(DetailImageCollectionViewCell.self, forCellWithReuseIdentifier: DetailImageCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.layer.cornerRadius = 12
        return collectionView
    }()
    
    private lazy var pageController: UIPageControl = {
        let pageController = UIPageControl()
        pageController.pageIndicatorTintColor = .gray
        pageController.currentPageIndicatorTintColor = .black
        return pageController
    }()
    
    // MARK: - Initialization -
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        pageController.addTarget(self, action: #selector(changePage(sender:)), for: .valueChanged)
        addSubview(collectionView)
        addSubview(pageController)
    }
    
    // MARK: - Setup -
    
    private func setupConstraints(){
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(150)
        }
        pageController.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(30)
            $0.width.equalTo(200)
            $0.top.equalTo(collectionView.snp.bottom).offset(8)
            $0.bottom.equalToSuperview()
        }
    }
        
    @objc func changePage(sender: UIPageControl) {
        let x = CGFloat(pageController.currentPage) * collectionView.frame.size.width
        collectionView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
    }
}

// MARK: - Extensions -

extension ImageView: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
}

extension ImageView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = items[indexPath.row]
        let cell = collectionView.dequeueReusableCell(
                   withReuseIdentifier: DetailImageCollectionViewCell.identifier,
                   for: indexPath
               ) as! DetailImageCollectionViewCell
//        cell.configure(with: items)
        cell.thumbnailImage.kf.setImage(with: ImageResource(downloadURL: URL(string: item)!))
        cell.backgroundColor = .yellow
        cell.isHideActionButton = isHideActionButton
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView{
            pageController.currentPage = indexPath.row
        }
    }
}

extension ImageView: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
      }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
}

