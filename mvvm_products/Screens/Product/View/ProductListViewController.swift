//
//  ProductListViewController.swift
//  mvvm_products
//
//  Created by Gaurav Sara on 26/07/23.
//

import UIKit

class ProductListViewController: UIViewController {

    private var viewModel = ProductViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configuration()
    }
}

extension ProductListViewController {
    func configuration() {
        initViewModel()
        observeEvent()
    }
    
    func initViewModel() {
        viewModel.fetchProducts()
    }
    
    // Observing event and do data binding
    func observeEvent() {
        viewModel.eventHandler = {[weak self] event in
            guard let self else { return }
            
            switch event {
            case .loading:
                print("data loading...")
            case .stopLoading:
                print("Stop loading...")
            case .dataLoaded:
                print("Data loaded...")
                print(viewModel.products, "Product List View Controller")
            case .error(let error):
                print(error)
            }
        }
    }
}
