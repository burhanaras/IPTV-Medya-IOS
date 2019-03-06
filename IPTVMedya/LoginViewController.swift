//
//  ViewController.swift
//  IPTVMedya
//
//  Created by BURHAN ARAS on 5.03.2019.
//  Copyright © 2019 BURHAN ARAS. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

  @IBOutlet weak var usernameTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var loginButton: UIButton!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    usernameTextField.delegate = self
    passwordTextField.delegate = self
    usernameTextField.returnKeyType = .next
    passwordTextField.returnKeyType = .done
  }

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == usernameTextField{
      usernameTextField.resignFirstResponder()
      passwordTextField.becomeFirstResponder()
    }else if textField == passwordTextField{
      passwordTextField.resignFirstResponder()
      login()
    }
    return true
  }

  @IBAction func onClick_LoginButton(_ sender: Any) {
    login()
  }
  
  func login(){
    let username = usernameTextField.text
    let password = passwordTextField.text
    
    if let username = username{
      if username.isEmpty{
        alert(message: "Kullanıcı Adı/Şifre boş bırakılamaz.")
      }
    }
    
    if let password = password {
      if password.isEmpty{
        alert(message: "Kullanıcı adı ve şifre boş bırakılamaz.")
      }
    }
  }
  
  func alert(message: String){
    let alert = UIAlertController(title: "HATA", message: message, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
  
}

