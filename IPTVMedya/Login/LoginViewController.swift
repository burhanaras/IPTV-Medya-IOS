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
  
  @IBOutlet weak var website: UIImageView!
  @IBOutlet weak var facebook: UIImageView!
  @IBOutlet weak var skype: UIImageView!
  @IBOutlet weak var speedtest: UIImageView!
  @IBOutlet weak var whatsapp: UIImageView!
  @IBOutlet weak var rememberMe: UISwitch!
  
  fileprivate var categories = [M3UPlayList]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    usernameTextField.delegate = self
    passwordTextField.delegate = self
    usernameTextField.returnKeyType = .next
    passwordTextField.returnKeyType = .done
    
    whatsapp.isUserInteractionEnabled = true
    whatsapp.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:))))
    website.isUserInteractionEnabled = true
    website.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:))))
    facebook.isUserInteractionEnabled = true
    facebook.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:))))
    skype.isUserInteractionEnabled = true
    skype.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:))))
    speedtest.isUserInteractionEnabled = true
    speedtest.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:))))
    rememberMe.addTarget(self, action: #selector(rememberMeStateChanged), for: .valueChanged)
    
    
    let isRememberMeChecked = UserDefaults.standard.bool(forKey: "rememberMe")
   rememberMe.isOn = isRememberMeChecked
    if isRememberMeChecked{
      usernameTextField.text = UserDefaults.standard.object(forKey: "username") as! String
      passwordTextField.text = UserDefaults.standard.object(forKey: "password") as! String
      login()
    }
    
  }
  
  @objc func rememberMeStateChanged(switchState: UISwitch) {
    if switchState.isOn {
      print("remember me")
      
    } else {
        print("forget me")
      let defaults = UserDefaults.standard
      defaults.set(false, forKey: "rememberMe")
      defaults.set("", forKey: "username")
      defaults.set("", forKey: "password")
    }
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
    print("Login()")
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
        categories = parser.parse2(contentsOfFile: contents)
        print("We have \(categories.count) categories here")
        for category in categories{
          print("\(String(describing: category.name)) has \(category.playListItems.count) items")
        }
        
        //save login info
        if rememberMe.isOn{
          let defaults = UserDefaults.standard
          defaults.set(true, forKey: "rememberMe")
          defaults.set(username, forKey: "username")
          defaults.set(password, forKey: "password")
        }else{
          let defaults = UserDefaults.standard
          defaults.set(false, forKey: "rememberMe")
          defaults.set("", forKey: "username")
          defaults.set("", forKey: "password")
        }
        
        CategoriesCollectionViewController.cats = categories
        performSegue(withIdentifier: "gotocategories", sender: categories)
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
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let data = sender as! [M3UPlayList]
    print("Data has \(data.count) items.")
    
    if segue.identifier == "goToCategoriesSegue" {
      let destinationVC = segue.destination as! CategoriesCollectionViewController
      destinationVC.categories = sender as! [M3UPlayList]
      
    }
  }
  
  
  @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
  {
    
    let tappedImage = tapGestureRecognizer.view as! UIImageView
    print("Image tapped \(tappedImage)")
    
    if tappedImage == whatsapp {
      print("Whatsapp!")
      openWhatsApp()
    }else if tappedImage == website{
      openWebSite()
    } else if tappedImage == facebook{
      openFacebook()
    }else if tappedImage == skype{
      openSkype()
    }else if tappedImage == speedtest{
      openSpeedTest()
    }
  }
  
  
  
  func openWebSite(){
    print("Open Website")
    if let url = URL(string: "http://www.iptvmedya.com"),
      UIApplication.shared.canOpenURL(url) {
      UIApplication.shared.open(url, options: [:])
    }
  }
  
  
  func openFacebook(){
    
  }
  
  func openSkype(){
    var skype: NSURL = NSURL(string: String(format: "skype:"))! //add object skype like this
    if UIApplication.shared.canOpenURL(skype as URL) {
      UIApplication.shared.openURL(URL(string: "skype:echo123?call")!)
    }
    else {
      // skype not Installed in your Device
      UIApplication.shared.openURL(URL(string: "http://itunes.com/apps/skype/skype")!)
    }
    
    
  }
  
  func openSpeedTest(){
    if let url = URL(string: "https://fast.com"),
      UIApplication.shared.canOpenURL(url) {
      UIApplication.shared.open(url, options: [:])
    }
  }
  
  func openWhatsApp(){
    let urlWhats = "whatsapp://send?phone=+32460242927"
    if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
      if let whatsappURL = URL(string: urlString) {
        if UIApplication.shared.canOpenURL(whatsappURL) {
          UIApplication.shared.openURL(whatsappURL)
        } else {
          print("Install Whatsapp")
        }
      }
    }
  }
  
  
}

