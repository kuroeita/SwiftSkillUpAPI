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
//        let urlString = "\(set.artworkUrl100)"
//        let urlRequest = NSURLRequest(URL: NSURL(string: urlString))
//        trackImage = urlRequest

        trackImage.setImageByDefault(with: set.artworkUrl100)


    }
}

extension UIImageView {

    func setImageByDefault(with url: URL) {

        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            // Success
            if error == nil, case .some(let result) = data, let image = UIImage(data: result) {
                DispatchQueue.main.async {
                    self?.image = image
                }
//                self?.image = image
            // Failure
            } else {
                // error handling

            }
        }.resume()
    }

}

