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
    
    
    if let url = URL(string: "http://goldiptv24.com:80/get.php?username=09e4OjOH4N&password=2X93EHak91&type=m3u_plus&output=ts") {
      do {
        let contents = try String(contentsOf: url)
    //    print(contents)
        let parser = M3UParser()
        let categories = parser.parse2(contentsOfFile: contents)
        print("We have \(categories.count) categories here")
        for category in categories{
          print("\(String(describing: category.name)) has \(category.playListItems.count) items")
        }
      } catch {
        print("contents could not be loaded")
         alert(message: "Kullanıcı adı ve şifre hatalı.")
      }
    } else {
      print("the URL was bad!")
       alert(message: "Kullanıcı adı ve şifre hatalı.")
    }
    
    
  }
  
  func alert(message: String){
    let alert = UIAlertController(title: "HATA", message: message, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
  
}

