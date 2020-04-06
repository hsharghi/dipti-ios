//
//  HHPickerView.swift
//  Dipti
//
//  Created by Hadi Sharghi on 4/6/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit


public protocol HHPickerViewDelegate {
    func pickerViewWillHide(_ pickerView: HHPickerView, in: TimeInterval)
    func pickerViewDidHide(_ pickerView: HHPickerView)
    func didSelectItem(_ pickerView: HHPickerView, item: String, at row: Int)
}

private protocol HHPickerViewModelDelegate {
    func hidePickerView()
    func titlesDidSet(titles: [String])
    func didSelectItem(at row: Int)
}

open class HHPickerView : UIPickerView, HHPickerViewModelDelegate {

    class HHPickerViewModel : NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
        var titles: [String] {
            didSet {
                delegate?.titlesDidSet(titles: titles)
            }
        }
        var selectionHandler: ((_ pickerView: UIPickerView, _ row: Int, _ title: String) -> ())?
        var hideDuration: TimeInterval
        fileprivate var delegate: HHPickerViewModelDelegate?
        var timer: Timer?
        
        init(titles: [String], hideDuration: TimeInterval, selectionHandler: ((_ pickerView: UIPickerView, _ row: Int, _ title: String) -> ())? = nil) {
            self.titles = titles
            self.hideDuration = hideDuration
            self.selectionHandler = selectionHandler
            
        }
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return titles.count
        }

        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return titles[row]
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            delegate?.didSelectItem(at: row)
            selectionHandler?(pickerView, row, titles[row])
            if hideDuration > 0 {
                timer?.invalidate()
                timer =  Timer.scheduledTimer(withTimeInterval: hideDuration, repeats: false, block: { (timer) in
                    self.delegate?.hidePickerView()
                    timer.invalidate()
                })
            }
        }
        


        func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
            let label = UILabel(frame: view.frame)
            label.text = titles[row]
            label.textAlignment = .center
            label.backgroundColor = AppData.color.yellow
            
            view.addSubview(label)
            view.transform = CGAffineTransform(rotationAngle: CGFloat(Double(90).toRad()))
            return view
            
        }
        
        func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
            return 60
        }
        
        

        
    }

    let model: HHPickerViewModel
    var HHDelegate: HHPickerViewDelegate?
    
    public init(titles: [String], hideDuration: TimeInterval, selectionHandler: ((_ pickerView: UIPickerView, _ row: Int, _ title: String) -> ())? = nil) {
        self.model = HHPickerViewModel(titles: titles, hideDuration: hideDuration, selectionHandler: selectionHandler)
        super.init(frame: .zero)
        
        self.delegate = model
        self.dataSource = model
        model.delegate = self
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        self.model = HHPickerViewModel(titles: [], hideDuration: 0, selectionHandler: nil)
        super.init(coder: aDecoder)
    }
    
    
    internal func hidePickerView() {
        HHDelegate?.pickerViewWillHide(self, in: 0.2)
        UIView.animate(withDuration: 0.2) {
            self.alpha = 0
            self.HHDelegate?.pickerViewDidHide(self)
        }
    }

    internal func titlesDidSet(titles: [String]) {
        self.reloadAllComponents()
    }
    
    public func showPickerView() {
       UIView.animate(withDuration: 0.2) {
           self.alpha = 1
       }
    }
    
    func didSelectItem(at row: Int) {
        HHDelegate?.didSelectItem(self, item: self.model.titles[row], at: row)
    }
    
    
}

