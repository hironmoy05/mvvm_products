//
//  ProductListViewController.swift
//  mvvm_products
//
//  Created by Gaurav Sara on 26/07/23.
//

import UIKit

class ProductListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        APIManager.shared.fetchProducts { response in
            switch response {
            case .success(let products):
                print(products)
            case .failure(let error):
                print(error)
            }
        }
    }
}
