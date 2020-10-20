//
//  StartVC.swift
//  ML
//
//  Created by Nestor Camela on 19/10/2020.
//  Copyright © 2020 Nestor Camela. All rights reserved.
//

import Foundation
import UIKit

class StartVC:UIViewController, UITextFieldDelegate{
    @IBOutlet var seachTxtField: UITextField!
    @IBOutlet var searchBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Inicio"
        seachTxtField.delegate = self
        if seachTxtField.text!.isEmpty{
            searchBtn.isUserInteractionEnabled = false
        }
        self.hideKeyboardWhenTappedAround()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "SearchVC") {
            let searchVC = segue.destination as! SearchVC
            print("Search: \(self.seachTxtField.text!)")
            searchVC.stringSearch = self.seachTxtField.text!
            
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = textField.text
        if (!text!.isEmpty || text!.count==0 ){
            searchBtn.isEnabled = true;
            searchBtn.isUserInteractionEnabled = true
        } else {
            searchBtn.isEnabled = false;
            searchBtn.isUserInteractionEnabled = false
        }
        return true
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()  //if desired
        let text = textField.text
        if (!text!.isEmpty || text!.count==0 ){
            searchBtn.sendActions(for: .touchUpInside)
        }
        
        return true
    }
    
}



extension UIViewController{
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}



extension UITableView {
    
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
    
    func showActivityIndicator() {
        let activityView = UIActivityIndicatorView(style: .large)
        activityView.center = self.center
        self.backgroundView = activityView
        self.separatorStyle = .none
        activityView.startAnimating()
    }
}
