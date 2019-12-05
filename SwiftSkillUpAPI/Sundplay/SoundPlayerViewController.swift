//
//  SoundPlayer.swift
//  SwiftSkillUpAPI
//
//  Created by 黒川瑛太郎 on 2019/12/05.
//  Copyright © 2019 Eitaro Kurokawa. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class SoundPlayerViewController: AVPlayerViewController {

    var trackName: String?
    var previewUrl: URL?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = trackName // title設定

        if let previewUrl = previewUrl {
            player = AVPlayer(url: previewUrl)
            player?.play() // 自動再生
        }
    }
}
