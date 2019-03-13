//
//  M3UParser.swift
//  IPTVMedya
//
//  Created by BURHAN ARAS on 7.03.2019.
//  Copyright © 2019 BURHAN ARAS. All rights reserved.
//

import Foundation

class M3UParser{
  
  let EXT_INF = "#EXTINF:"
  let EXT_GROUP_TITLE = "group-title"
  
  
  func parse(contentsOfFile: String) -> [M3UItem]{
    var mediaItems = [M3UItem]()
    contentsOfFile.enumerateLines(invoking: { line, stop in
      if line.hasPrefix("#EXTINF:") {
        let infoLine    = line.replacingOccurrences(of: "#EXTINF:", with: "")
        let infos       = Array(infoLine.components(separatedBy: ","))
        if let firstPart = infos.first {
          let m3UItem = M3UItem()
          m3UItem.itemName = infos.last
          
          let secondInfos = Array(firstPart.components(separatedBy: "group-title"))
          if secondInfos.first != nil{
            m3UItem.groupTitle = secondInfos.last?.replacingOccurrences(of: "=", with: "").replacingOccurrences(of: "\"", with: "")
          }
          
          
          mediaItems.append(m3UItem)
        }
      } else {
        if mediaItems.count > 0 {
          let item = mediaItems.last
          item?.itemUrl = line
        }
      }
    })
    return mediaItems
  }
  
  func parse2(contentsOfFile: String) -> [M3UPlayList]{
    var playlists = [String: [M3UItem]]()
    
    let m3uItems = parse(contentsOfFile: contentsOfFile)
    print("We have \(m3uItems.count) items here")
    for m3u in m3uItems{
      
      if let name = m3u.groupTitle{
        if playlists[name] != nil{
          var array = playlists[name]
          array?.append(m3u)
          playlists[name] = array
        }else{
          var array = [M3UItem]()
          array.append(m3u)
          playlists[name] = array
        }
      }
    }
    
    print("We have \(playlists.count) items in playlist ")
    
    let sortedKeys = playlists.keys.sorted()
    
    var categories = [M3UPlayList]()
    for key in sortedKeys{
      if key != "" && playlists[key] != nil{
        let category = M3UPlayList()
        category.name = key
        category.playListItems = playlists[key]!
        categories.append(category)
      }
     
    }
    
    
    return categories
  }
  
}
