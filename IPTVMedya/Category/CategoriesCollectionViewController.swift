//
//  CategoriesCollectionViewController.swift
//  IPTVMedya
//
//  Created by BURHAN ARAS on 10.03.2019.
//  Copyright © 2019 BURHAN ARAS. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CategoriesCollectionViewController: UICollectionViewController, UISearchBarDelegate {
  
  private var isSearchActive: Bool = false
  public var categories: [M3UPlayList] = [M3UPlayList]()
  public static var cats = [M3UPlayList](){
    didSet{
      filteredData = cats
    }
  }
  public static var filteredData = [M3UPlayList]()
  fileprivate let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
  
  lazy var searchBar:UISearchBar = UISearchBar()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationController?.navigationBar.prefersLargeTitles = true
    searchBar.sizeToFit()
    searchBar.placeholder = "Arama"
    searchBar.delegate = self
    var leftNavBarButton = UIBarButtonItem(customView:searchBar)
    self.navigationItem.leftBarButtonItem = leftNavBarButton
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Register cell classes
    self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    
    // Do any additional setup after loading the view.
    collectionView.reloadData()
    print("We have \(categories.count) categories")
    print("We have \(CategoriesCollectionViewController.cats.count) cats")
  }
  
  override func viewDidAppear(_ animated: Bool) {
    self.navigationController?.navigationBar.isHidden = false
  }
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using [segue destinationViewController].
   // Pass the selected object to the new view controller.
   }
   */
  
  // MARK: UICollectionViewDataSource
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of items
    return CategoriesCollectionViewController.filteredData.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellforcategory", for: indexPath) as! MyCollectionViewCell
    
    // Configure the cell
    
    cell.nameLabel.text = CategoriesCollectionViewController.filteredData[indexPath.row].name
    cell.countLabel.text = String(describing: "Toplam Yayın Sayısı: \(CategoriesCollectionViewController.filteredData[indexPath.row].playListItems.count)")
    
    return cell
  }
  
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let categoryDetailVC = mainStoryboard.instantiateViewController(withIdentifier: "categoryDetailVC") as? CategoryDetailCollectionViewController else {return}
    categoryDetailVC.playlist = CategoriesCollectionViewController.filteredData[indexPath.row]
    navigationController?.pushViewController(categoryDetailVC, animated: true)
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
  
  //MARK: search bar
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    print("New text is \(searchText)")
    CategoriesCollectionViewController.filteredData = CategoriesCollectionViewController.cats.filter { obj  in
      return obj.name?.lowercased().contains(searchText.lowercased()) ?? false
    }
    
    print("Search returned \(CategoriesCollectionViewController.filteredData.count) items.")
    if searchText.isEmpty {
      CategoriesCollectionViewController.filteredData = CategoriesCollectionViewController.cats
    }
    
    collectionView.reloadData()
  }
}
