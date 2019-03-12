//
//  CategoryDetailCollectionViewController.swift
//  IPTVMedya
//
//  Created by BURHAN ARAS on 12.03.2019.
//  Copyright © 2019 BURHAN ARAS. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CategoryDetailCollectionViewController: UICollectionViewController {

  var playlist: M3UPlayList? = nil
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

      navigationController?.navigationBar.prefersLargeTitles = true
    
      self.navigationController?.navigationBar.backItem?.title = "Kategoriler"
      self.title = "IPTV Medya" // "\(String(describing: playlist?.name))"
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
      print("We have \(String(describing: playlist?.playListItems.count))")
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
        // #warning Incomplete implementation, return the number of items
      return playlist?.playListItems.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellForCategoryDetail", for: indexPath) as! CategoryDetailViewCell
    
        // Configure the cell
      
      cell.titleLabel.text = playlist?.playListItems[indexPath.row].itemName
    
        return cell
    }

  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    performSegue(withIdentifier: "goToPlayer", sender: playlist?.playListItems[indexPath.row])
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

}
