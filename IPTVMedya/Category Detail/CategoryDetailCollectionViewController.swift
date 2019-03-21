//
//  CategoryDetailCollectionViewController.swift
//  IPTVMedya
//
//  Created by BURHAN ARAS on 12.03.2019.
//  Copyright © 2019 BURHAN ARAS. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CategoryDetailCollectionViewController: UICollectionViewController, UISearchBarDelegate {
  
  var resultSearchController = UISearchController()
  lazy var searchBar:UISearchBar = UISearchBar()
  
  var playlist: M3UPlayList? = nil{
    didSet{
      filteredData = (playlist?.playListItems)!
    }
  }
  private var filteredData:[M3UItem] = [M3UItem]()
  private var isSearchActive: Bool = false
  
    fileprivate let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    navigationController?.navigationBar.prefersLargeTitles = false
    
    self.navigationController?.navigationBar.backItem?.title = "Kategoriler"
    self.title = playlist?.name // "IPTV Medya" // "\(String(describing: playlist?.name))"
    // Register cell classes
    self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    
    // Do any additional setup after loading the view.
    print("We have \(String(describing: playlist?.playListItems.count))")

    
    var newBackButton = UIBarButtonItem(title: "Geri", style: .done, target: nil, action: nil)
    self.navigationItem.backBarButtonItem = newBackButton
    
    searchBar.sizeToFit()
    searchBar.placeholder = "Arama"
    searchBar.delegate = self
    var leftNavBarButton = UIBarButtonItem(customView:searchBar)
    self.navigationItem.rightBarButtonItem = leftNavBarButton
  
    
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar .resignFirstResponder()
    searchBar.setShowsCancelButton(false, animated: true)
  }
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    searchBar.setShowsCancelButton(true, animated: true)
  }
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    searchBar.setShowsCancelButton(false, animated: true)
  }
  
  
  func makeBackButton() -> UIButton {
    let backButtonImage = UIImage(named: "backbutton")?.withRenderingMode(.alwaysTemplate)
    let backButton = UIButton(type: .custom)
    backButton.setImage(backButtonImage, for: .normal)
    backButton.tintColor = .blue
    backButton.setTitle("  Geri", for: .normal)
    backButton.setTitleColor(.blue, for: .normal)
    backButton.addTarget(self, action: #selector(self.backButtonPressed), for: .touchUpInside)
    return backButton
  }
  
  @objc func backButtonPressed() {
    dismiss(animated: true, completion: nil)
    //        navigationController?.popViewController(animated: true)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    self.navigationController?.navigationBar.isHidden = false
  }
  
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if segue.identifier == "goToPlayer"{
      let player = segue.destination as! PlayerViewController
      player.m3uItem = sender as! M3UItem
    }
  }
  
  
  // MARK: UICollectionViewDataSource
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    if isSearchActive{
      return filteredData.count
    }else{
      return playlist?.playListItems.count ?? 0
    }
    
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellForCategoryDetail", for: indexPath) as! CategoryDetailViewCell
    
    // Configure the cell
    var item: M3UItem
    if isSearchActive{
      item = filteredData[indexPath.row]
    }else{
      item = (playlist?.playListItems[indexPath.row])!
    }
    
    cell.titleLabel.text = item.itemName
    
    return cell
  }
  
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
   /*
    performSegue(withIdentifier: "goToPlayer", sender: playlist?.playListItems[indexPath.row])
    */
    
    guard let playerVC = mainStoryboard.instantiateViewController(withIdentifier: "player") as? PlayerViewController else {return}
    playerVC.m3uItem = playlist?.playListItems[indexPath.row]
    navigationController?.pushViewController(playerVC, animated: true)
    
    
    
  }
  // MARK: UICollectionViewDelegate
  
  /*
   // Uncomment this method to specify if the specified item should be highlighted during tracking
   override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
   return true
   }
   */
  
  /*
   // Uncomment this method to specify if the specified item should be selected
   override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
   return true
   }
   */
  
  /*
   // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
   override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
   return false
   }
   
   override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
   return false
   }
   
   override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
   
   }
   */
  
  // MARK: Search
  
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    print("New text is \(searchText)")
    if searchText.isEmpty{
      isSearchActive = false
    }else{
      isSearchActive = true
    }
    
    if isSearchActive{
      
      filteredData = (playlist?.playListItems.filter { obj  in
        return obj.itemName?.lowercased().contains(searchText.lowercased()) ?? false
        })!
      
      print("Search returned \(filteredData.count) items.")
      
    }
    
    collectionView.reloadData()
  }
}
