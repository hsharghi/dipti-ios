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

        roundButtons(in: self.view)
        setTextFieldAlignments(in: self.view)
    }
    
    private func setTextFieldAlignments(in view: UIView) {
        view.subviews.forEach { (view) in
            if let textBox = view as? SkyFloatingLabelTextField {
                textBox.textAlignment = .center
                textBox.titleLabel.textAlignment = .center
            }
            if view.subviews.count > 0 {
                setTextFieldAlignments(in: view)
            }
        }
    }
    
    private func roundButtons(in view: UIView) {
        view.subviews.forEach { (view) in
            if let button = view as? UIButton {
                button.roundConrners(masks: .allCorners, radius: 16)
            }
            if view.subviews.count > 0 {
                roundButtons(in: view)
            }
        }
    }
    
}

