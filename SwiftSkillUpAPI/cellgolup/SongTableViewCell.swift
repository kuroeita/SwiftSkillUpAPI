//
//  SongTableViewCell.swift
//  SwiftSkillUpAPI
//
//  Created by 黒川瑛太郎 on 2019/11/04.
//  Copyright © 2019 Eitaro Kurokawa. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    
    @IBOutlet weak var trackImage: UIImageView!
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setup(set: Result) {
        trackName.text = set.trackName
        artistName.text = set.artistName
    }
    
}
