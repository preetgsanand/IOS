//
//  VideoCell.swift
//  YPlayer
//
//  Created by Preet G S Anand on 11/23/17.
//  Copyright © 2017 Preet G S Anand. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class VideoCell: UICollectionViewCell, YTPlayerViewDelegate {
    @IBOutlet weak var player : YTPlayerView!
    @IBOutlet weak var title : UILabel!
    
    func configure(video : Video) {
        player.load(withVideoId: video.key)
        player.playVideo()
        title.text = video.title
    }
    
    
}
