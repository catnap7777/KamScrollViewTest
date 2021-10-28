//
//  ViewController.swift
//  KamScrollViewTest
//
//  Created by Karen Mathes on 10/28/21.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate {

    @IBOutlet var name: UITextField!
    @IBOutlet var addr1: UITextField!
    @IBOutlet var addr2: UITextField!
    @IBOutlet var city: UITextField!
    @IBOutlet var state: UITextField!
    @IBOutlet var zip: UITextField!
    @IBOutlet var phone: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var pword: UITextField!
    
    @IBOutlet var msgLabel: UILabel!
    
    @IBOutlet var uiScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //name.becomeFirstResponder()
        uiScrollView.contentOffset = CGPoint(x:0, y:0)
        
        uiScrollView.delegate = self
        
        name.delegate = self
        addr1.delegate = self
        addr2.delegate = self
        city.delegate = self
        state.delegate = self
        zip.delegate = self
        phone.delegate = self
        email.delegate = self
        pword.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        name.becomeFirstResponder()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    
        //.. for tap to make keyboard dismiss
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self , action: #selector(self.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        uiScrollView.contentInset.bottom = 0
    }
    
    //..  @objc funcs are for keyboard dismiss
    @objc func dismissKeyboard() {
        view.endEditing( true )
    }
    
    //..  @objc funcs are for keyboard dismiss
    @objc func keyboardWillShow(notification: NSNotification) {
        msgLabel.text = "(Tap here to dismiss keyboard)"
        guard let keyboardFrame = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        uiScrollView.contentInset.bottom = view.convert(keyboardFrame.cgRectValue, from: nil).size.height
    }
    
    //..  @objc funcs are for keyboard dismiss
    @objc func keyboardWillHide(notification: NSNotification) {
        msgLabel.text = ""
        uiScrollView.contentInset.bottom = 0
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case name:
            addr1.becomeFirstResponder()
        case addr1:
            addr2.becomeFirstResponder()
        case addr2:
            city.becomeFirstResponder()
        case city:
            state.becomeFirstResponder()
        case state:
            zip.becomeFirstResponder()
        case zip:
            phone.becomeFirstResponder()
        case phone:
            email.becomeFirstResponder()
        case email:
            pword.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return false
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            if scrollView.contentOffset.x != 0 {
                scrollView.contentOffset.x = 0
            }
    }


}



