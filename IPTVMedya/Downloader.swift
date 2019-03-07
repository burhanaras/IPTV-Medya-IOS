//
//  Downloader.swift
//  IPTVMedya
//
//  Created by BURHAN ARAS on 7.03.2019.
//  Copyright © 2019 BURHAN ARAS. All rights reserved.
//

import Foundation


class Downloader {
  class func load(url: URL, to localUrl: URL, completion: @escaping () -> ()) {
    let sessionConfig = URLSessionConfiguration.default
    let session = URLSession(configuration: sessionConfig)
    let request = try! URLRequest(url: url)
    
    let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
      if let tempLocalUrl = tempLocalUrl, error == nil {
        // Success
        if let statusCode = (response as? HTTPURLResponse)?.statusCode {
          print("Success: \(statusCode)")
        }
        
        do {
          try FileManager.default.copyItem(at: tempLocalUrl, to: localUrl)
          completion()
        } catch (let writeError) {
          print("error writing file \(localUrl) : \(writeError)")
        }
        
      } else {
        print("Failure: %@", error?.localizedDescription);
      }
    }
    task.resume()
  }
}
