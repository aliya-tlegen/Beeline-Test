//
//  MainPageViewModel.swift
//  Beeline Test
//
//  Created by Алия Тлеген on 11.11.2022.
//

import Foundation

protocol MainPageViewModelProtocol: AnyObject {
    func loadProducts()
}


class MainPageViewModel {
    
    weak var delegate: MainPageViewModelProtocol?
    
    var productsModel: Product?
    
    let service: NetworkProvider!
    
    init(service: NetworkProvider) {
        self.service = service
    }
        
    func fetchProducts(){
        service.getProducts { [weak self] result in
            guard let strongSelf = self else { return }
            switch result{
            case .success(let response):
                strongSelf.productsModel = response
                strongSelf.delegate?.loadProducts()
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
