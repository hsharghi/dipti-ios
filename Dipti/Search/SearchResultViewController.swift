//
//  SearchResultViewController.swift
//  Dipti
//
//  Created by Hadi Sharghi on 4/7/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit

protocol SearchResultViewDelegate: class {
    func closeButtonTapped()
    func hideKeyboard()
}

class SearchResultViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleView: UIView!
    weak var delegate: SearchResultViewDelegate?
    
    let products = ProductMockFactory.mockProducts(count: 30)
    
    var searchTerm = "" {
        didSet {
            getResult(with: searchTerm)
        }
    }
    
    var result = SearchResult() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.roundConrners(masks: .bottomCorners, radius: 20)
        titleView.roundConrners(masks: .topCorners, radius: 20)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        delegate?.hideKeyboard()
    }
    
    
    private func getResult(with term: String) {
        
        let searchResult = SearchResult()
        searchResult.products = products
            .filter { $0.title.contains(term) || $0.description.contains(term) }
            .uniqueElements
        
        searchResult.categories = products
            .filter { $0.category.name.contains(term) }
            .compactMap({ (product) -> Category? in
                product.category
            })
            .uniqueElements
        
        searchResult.designers = products
            .filter({$0.designer.contains(term)})
            .compactMap({$0.designer})
            .uniqueElements
        
        result = searchResult
    }
    
    
    public func setSearchTerm(term: String) {
        searchTerm = term
    }
    
    
    @IBAction func closeTapped(_ sender: Any) {
        delegate?.closeButtonTapped()
    }
}


extension SearchResultViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return result.products?.count ?? 0
        case 1:
            return result.categories?.count ?? 0
        case 2:
            return result.designers?.count ?? 0
            
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath)
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = result.products?[indexPath.row].title
        case 1:
            cell.textLabel?.text = result.categories?[indexPath.row].name
        case 2:
            cell.textLabel?.text = result.designers?[indexPath.row]
        default:
            return UITableViewCell()
        }
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "کالاها"
        case 1:
            return "دسته‌بندی‌ها"
        case 2:
            return "طراحان"
        default:
            return ""
        }
    }
    
    
    
}

class SearchResult {
    
    var products: [Product]?
    var categories: [Category]?
    var designers: [String]?
    
    
    
    
    
}
