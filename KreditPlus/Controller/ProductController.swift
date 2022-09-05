//
//  ItemsViewController.swift
//  KreditPlus
//
//  Created by Novi Gunawan on 04/09/22.
//

import UIKit

class ProductController: UITableViewController, UpdateTableView {
    func update(indexPath: [IndexPath]) {
        tableView.reloadRows(at: indexPath, with: .none)
    }
    

    
    var productsViewModel = [ProductViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
        setupTableView()
        fetchData()

        
    }
    
    fileprivate func fetchData() {
        Service.shared.fetchProducts { products, error in
            if let error = error {
                print("Failed to fetch products:", error)
                return
            }
            self.productsViewModel = products?.map({return ProductViewModel(product: $0)}) ?? []
            self.tableView.reloadData()
        }
    }
    
    fileprivate func setupNavbar() {
        let navbar = navigationController?.navigationBar
        navigationItem.title = "Products"
        navbar?.prefersLargeTitles = true
        navbar?.backgroundColor = .black
        navbar?.isTranslucent = false
        navbar?.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
    }
    
    fileprivate func setupTableView() {
        tableView.register(ProductCell.self, forCellReuseIdentifier: Constant.cellName)
        tableView.backgroundColor = .white
//        tableView.separatorColor = .gray
//        tableView.separatorInset = UIEdgeInsets(top: 10, left: 24, bottom: 10, right: 24)
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = view.frame.height/6
        tableView.dataSource = self
        tableView.allowsSelection = false
        
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsViewModel.count
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.cellName, for: indexPath) as! ProductCell
        cell.selectionStyle = .none
        cell.isUserInteractionEnabled = false
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.cellName, for: indexPath) as! ProductCell
        cell.indexPathTableView = indexPath
        cell.delegate = self
        let productViewModel = productsViewModel[indexPath.row]
        
        Service.shared.loadFrom(urlAddress: productViewModel.image) { response in
            switch response {
            case .success(let image):
                DispatchQueue.main.async {
                    cell.image.image = image
                    cell.layoutIfNeeded()
                }
            case .fail:
                break
            }
        }
        cell.productViewModel = productViewModel
        return cell
    }

    
}
