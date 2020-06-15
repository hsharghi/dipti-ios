//
//  FormViewController.swift
//  Dipti
//
//  Created by Hadi Sharghi on 5/10/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField


class FormViewController: UIViewController, UITextFieldDelegate {
    
    private var _scrollView: UIScrollView?
    private var _contentView: UIView?
    
    
    func setupScrollView(_ scrollView: UIScrollView, contentView: UIView) {
        _scrollView = scrollView
        _contentView = contentView
        registerForKeyboardEvents()
    }
    
    override func viewDidLoad() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
        view.addGestureRecognizer(tapGestureRecognizer)
        
        setupView()
        self.view.subviews.forEach { (view) in
            if let textField = view as? SkyFloatingLabelTextField {
                textField.delegate = self
            }
        }
    }
  
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let textField = textField as? SkyFloatingLabelTextField {
            textField.errorMessage = nil
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let textField = textField as? SkyFloatingLabelTextField {
            textField.errorMessage = nil
        }
    }
    
    @objc private func viewTapped(_ sender: Any) {
        view.endEditing(true)
    }
    
    private func registerForKeyboardEvents() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    
    @objc func keyboardWillShow(notification:NSNotification){
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardFrame = self.view.convert(keyboardSize, from: nil)
            
            var contentInset:UIEdgeInsets = self._scrollView?.contentInset ?? .zero
            contentInset.bottom = keyboardFrame.size.height
            _scrollView?.contentInset = contentInset
        }
    }
    
    @objc func keyboardWillHide(notification:NSNotification){
        
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        UIView.animate(withDuration: 0.3) {
            self._scrollView?.contentInset = contentInset
        }
        
    }
    
    
    private func setupView() {
        let attributes = [NSAttributedString.Key.font: UIFont(name: "IRANSansWeb-Bold", size: 18)!]
        self.navigationController?.navigationBar.titleTextAttributes = attributes

        roundButtons(in: self.view)
        setupTextFields(in: self.view)
    }
    
    private func setupTextFields(in view: UIView) {
        view.subviews.forEach { (view) in
            if let textBox = view as? SkyFloatingLabelTextField {
                textBox.delegate = self
                textBox.lineColor = .clear
                textBox.roundConrners(masks: .allCorners, radius: 10)
                textBox.titleColor = .clear
                textBox.backgroundColor = UIColor(hexString: "F5F5F5")
                textBox.titleFont = UIFont(name: "IRANSansWeb", size: 6)!
                textBox.font = UIFont(name: "IRANSansWeb", size: 16)!
                textBox.selectedTitleColor = .clear
                textBox.selectedLineColor = UIColor(hexString: "F5F5F5")
                textBox.titleLabel.textAlignment = textBox.textAlignment
                if textBox.isSecureTextEntry {
                    textBox.textAlignment = .center
                }
            }
            if view.subviews.count > 0 {
                setupTextFields(in: view)
            }
        }
    }
    
    private func roundButtons(in view: UIView) {
        view.subviews.forEach { (view) in
            if let button = view as? UIButton {
                button.roundConrners(masks: .allCorners, radius: 10)
            }
            if view.subviews.count > 0 {
                roundButtons(in: view)
            }
        }
    }
        
}

