//
//  EditProfileViewController.swift
//  Dipti
//
//  Created by Hadi Sharghi on 6/17/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit

class EditProfileViewController: FormViewController {
    
    @IBOutlet weak var firstName: TitleBarTextField!
    @IBOutlet weak var lastName: TitleBarTextField!
    @IBOutlet weak var phoneNumber: TitleBarTextField!
    @IBOutlet weak var gender: UISegmentedControl!
    //    @IBOutlet weak var confirmPassword: SkyFloatingLabelTextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    weak var delegate: UpdateProfile?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView(scrollView, contentView: contentView)
        view.viewWithTag(99)?.roundConrners(masks: .allCorners, radius: 8)
        populateData()
    }

    
    private func populateData() {
        if let customer = AppData.customer {
            firstName.text = customer.firstName
            lastName.text = customer.lastName
            phoneNumber.text = customer.phoneNumber
            gender.selectedSegmentIndex = customer.gender == "f" ? 0 : 1
        }
    }
    

        @IBAction func saveButtonTapped(_ sender: Any) {
            guard validateFields() else { return }
            
            if let customer = AppData.customer?.with(firstName: firstName.text!, lastName: lastName.text!, gender: gender.selectedSegmentIndex == 0 ? "f" : "m") {
                flashLoading(for: 1.5) {
                    CustomerRepository.update(customer: customer)
                    self.delegate?.profileUpdated()
                    self.dismiss(animated: true, completion: nil)
                }
            }
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
            
            if let phoneNumber = phoneNumber.text, !phoneNumber.isEmpty, phoneNumber.digits != phoneNumber {
                self.phoneNumber.errorMessage = "شماره تلفن همراه نامعتبر است"
                validation = false
            }
            
            return validation
        }
        
}
