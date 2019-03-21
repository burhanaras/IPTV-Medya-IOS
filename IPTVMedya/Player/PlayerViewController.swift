//
//  PlayerViewController.swift
//  IPTVMedya
//
//  Created by BURHAN ARAS on 12.03.2019.
//  Copyright © 2019 BURHAN ARAS. All rights reserved.
//

import UIKit
import MediaPlayer
import AVKit
import AVFoundation

class PlayerViewController: UIViewController {

  var m3uItem: M3UItem? = nil
  let defaultUrl = "http://goldiptv24.com:80/09e4OjOH4N/2X93EHak91/13027"//http://devstreaming.apple.com/videos/wwdc/2016/102w0bsn0ge83qfv7za/102/hls_vod_mvp.m3u8"
  var streamPlayer : MPMoviePlayerController =  MPMoviePlayerController(contentURL: NSURL(string: "http://devstreaming.apple.com/videos/wwdc/2016/102w0bsn0ge83qfv7za/102/hls_vod_mvp.m3u8") as! URL)

    override func viewDidLoad() {
        super.viewDidLoad()

      self.navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
      streamPlayer.view.frame = self.view.bounds
      self.view.addSubview(streamPlayer.view)
      
      streamPlayer.isFullscreen = true
      streamPlayer.contentURL = NSURL(string: m3uItem?.itemUrl ?? defaultUrl)! as URL
      // Play the movie!
     // streamPlayer.play()
      
      print("Play url is \(m3uItem?.itemUrl)")
      
      if let url = URL(string: m3uItem?.itemUrl ?? defaultUrl){
        
        let player = AVPlayer(url: url)
        let controller=AVPlayerViewController()
        controller.player=player
        controller.view.frame = self.view.frame
        self.view.addSubview(controller.view)
        self.addChild(controller)
        
      //  self.present(controller, animated: true, completion: nil)
        player.play()
      }
      
      
    }
  
  
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
