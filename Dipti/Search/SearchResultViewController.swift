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
    func productTapped(product: Product)
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
        delegate?.hideKeyboard()
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
        
        switch indexPath.section {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SearchProductCell.self), for: indexPath) as? SearchProductCell {
                cell.product = result.products?[indexPath.row]
                return cell
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SearchCategoryCell.self), for: indexPath) as? SearchCategoryCell {
                cell.category = result.categories?[indexPath.row]
                return cell
            }
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SearchDesignerCell.self), for: indexPath) as? SearchDesignerCell {
                cell.designer = result.designers?[indexPath.row]
                return cell
            }
        default: break
        }
                return UITableViewCell()

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let title = titleForHeader(in: section)
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 20))
        view.backgroundColor = headerIsEnabled(in: section) ? AppData.color.yellow : .lightGray
        let label = UILabel(frame: CGRect(x: 0, y: 6, width: self.view.bounds.width - 30, height: 20))
        label.font = UIFont(name: "IRANSansWeb-Bold", size: 16)
        label.text = title
        label.textColor = headerIsEnabled(in: section) ? .black : .darkGray
        label.textAlignment = .right
        view.addSubview(label)
        return view
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            if let product = result.products?[indexPath.row] {
                closeTapped(tableView)
                delegate?.productTapped(product: product)
            }
            
        default:
            return
        }
    }
    
    
    private func titleForHeader(in section: Int) -> String? {
        switch section {
        case 0:
            return "کالاها"
        case 1:
            return "دسته‌بندی‌ها"
        case 2:
            return "طراحان"
        default: break
            
        }

        return nil
    }
    
    
    private func headerIsEnabled(in section: Int) -> Bool {
        switch section {
        case 0:
            return result.products?.count ?? 0 > 0
        case 1:
            return result.categories?.count ?? 0 > 0
        case 2:
            return result.designers?.count ?? 0 > 0
            
        default: break
            
        }

        return false
    }
    
    
}

class SearchResult {
    
    var products: [Product]?
    var categories: [Category]?
    var designers: [String]?
    
    
    
    
    
}
