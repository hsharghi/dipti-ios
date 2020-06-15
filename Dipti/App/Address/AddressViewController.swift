//
//  AddressViewController.swift
//  Dipti
//
//  Created by Hadi Sharghi on 6/15/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit

class AddressViewController: FormViewController {

    var address: Address?
    
    @IBOutlet weak var firstName: TitleBarTextField!
    @IBOutlet weak var lastName: TitleBarTextField!
    @IBOutlet weak var city: TitleBarTextField!
    @IBOutlet weak var street: UITextView!
    @IBOutlet weak var postalCode: TitleBarTextField!
    @IBOutlet weak var phoneNumber: TitleBarTextField!
    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        removeButton.isHidden = address == nil
    }
    
    
    private func setupView() {
        
        setupScrollView(scrollView, contentView: contentView)
        
        if address == nil {
            navigationItem.title = "آدرس جدید"
        } else {
            navigationItem.title = "ویرایش آدرس"
        }
        
        street.roundConrners(masks: .allCorners, radius: 10, color: AppData.color.lightGray)
        street.backgroundColor = AppData.color.lightGray
        populateAddressFields()
    }
    
    
    fileprivate func populateAddressFields() {
        firstName.text = address?.firstName
        lastName.text = address?.lastName
        city.text = address?.city
        street.text = address?.street
        postalCode.text = address?.postcode
        phoneNumber.text = address?.phoneNumber
    }
    

    
    @IBAction func removeButtonTapped(_ sender: Any) {
        guard let id = address?.id else { return }
        AppHelper.showAlert("حذف", message: "آیا این آدرس حذف شود؟", actions: [
            UIAlertAction(title: "بله", style: .destructive, handler: { (action) in
                AddressRepository.remove(id: id)
                self.dismiss(animated: true, completion: nil)
            }),
            UIAlertAction(title: "خیر", style: .cancel)
        ])
        return
    }
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        guard validateFields() else { return }
        
        var address: Address
        
        if self.address == nil {
            address = Address(id: Int.random(in: 100_000...999_999), firstName: firstName.text!, lastName: lastName.text!,
                              countryCode: "IR", street: street.text ?? "", city: city.text!,
                              postcode: postalCode.text!, phoneNumber: phoneNumber.text!)
            self.address = AddressRepository.add(address: address)
            
            flashLoading(for: 0.5) {
                self.navigationController?.popViewController(animated: true)
            }

        } else {
            address = self.address!
            address.firstName = firstName.text!
            address.lastName = lastName.text!
            address.city = city.text!
            address.street = street.text ?? ""
            address.postcode = postalCode.text!
            address.phoneNumber = phoneNumber.text!
            self.address = AddressRepository.update(address: address)
            flashLoading(for: 0.5) {
                
            }
        }
        
        populateAddressFields()

    }
    

        private func validateFields() -> Bool {
            var validation = true
            
            if (firstName.text ?? "").isEmpty {
                firstName.errorMessage = "نام خود را وارد کنید"
                validation = false
            }
            
            if (lastName.text ?? "").isEmpty {
                lastName.errorMessage = "نام خانوادگی خود را وارد کنید"
                validation = false
            }
            
//            if (street.text ?? "").isEmpty {
//                street.errorMessage = "نام خانوادگی خود را وارد کنید"
//                validation = false
//            }
            
            if let phoneNumber = phoneNumber.text, !phoneNumber.isEmpty, phoneNumber.digits != phoneNumber {
                self.phoneNumber.errorMessage = "شماره تلفن همراه نامعتبر است"
                validation = false
            }
            
            if (city.text ?? "").isEmpty {
                city.errorMessage = "نام شهر را وارد کنید"
                validation = false
            }
            
            if let postcode = postalCode.text {
                if postcode.isEmpty || postcode.count != 10 {
                    self.postalCode.errorMessage = "کدپستی نامعتبر است"
                    validation = false
                }
            }
            
            return validation
        }
}
