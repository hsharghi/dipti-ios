//
//  AddressViewController.swift
//  Dipti
//
//  Created by Hadi Sharghi on 6/15/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit


class AddressListTableViewController: UITableViewController {
    
    static let cellID = "addressListCell"
    
    var addresses: [Address] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let attributes = [NSAttributedString.Key.font: UIFont(name: "IRANSansWeb-Bold", size: 18)!]
        self.navigationController?.navigationBar.titleTextAttributes = attributes

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addresses = AddressRepository.list()
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(#function)
    }
    
    @IBAction func addNewButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "showAddressDetail", sender: self)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addresses.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Self.cellID, for: indexPath)
        cell.textLabel?.text = addresses[indexPath.row].street
        cell.detailTextLabel?.text = addresses[indexPath.row].city
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? AddressViewController {
            if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
                vc.address = addresses[indexPath.row]
            }
        }
    }
}
