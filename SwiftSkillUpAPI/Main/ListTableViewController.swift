//
//  ListTableViewController.swift
//  SwiftSkillUpAPI
//
//  Created by 黒川瑛太郎 on 2019/11/04.
//  Copyright © 2019 Eitaro Kurokawa. All rights reserved.
//

import UIKit
import Moya

class ListTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    var resultsCount: NestTitle?
    //3.変換した値を見ている、NestTitleが型であることを明示
    var titleString: String?

    override func viewDidLoad() {

        super.viewDidLoad()
        searchBar.delegate = self

        self.tableView.register(UINib(nibName: "SongTableViewCell", bundle: nil), forCellReuseIdentifier: "SongTableViewCell")


    }

    func showNetworkAlert() {
        let networkAlert = UIAlertController(title: "通信に失敗しました", message: "電波状況を確認の上、もう一度お試しください", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style:  .default, handler:  nil)
        networkAlert.addAction(alertAction)

        present(networkAlert, animated: true, completion: nil)
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollPositionThreshold: CGFloat = 300
        let screenHeight = scrollView.bounds.size.height
        let contentSize = scrollView.contentSize.height
        let currentOffset = scrollView.contentOffset.y
        if contentSize - currentOffset - screenHeight < scrollPositionThreshold {
            return
        }
    }


    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()

        let inText = searchBar.text!

        let provider = MoyaProvider<ITunesAPI>()
        provider.request( .searchInformation(term: "\(inText)")) { [weak self] results in
            switch results {
            case let .success(moyaResponse):
                let jsonData = try? JSONDecoder().decode(NestTitle.self, from: moyaResponse.data)
                //1.ここのクロージャー内でjsonデータを取得してNestTitleの型通りに変換するよっていつのをcodbleで実装
                self?.resultsCount = jsonData
                //2.変換した値をresultskCountに入れている

                self?.tableView.reloadData()


            case let .failure(error):
                self?.showNetworkAlert()
                print("アクセスに失敗しました:\(error)")

            }

        }


    }



    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if resultsCount?.results?.count == 0 {
            tableView.setEmptyView(title: "エラー", message: "検索結果なし")

        } else{
            tableView.restore()
        }
        return resultsCount?.results?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SongTableViewCell") as? SongTableViewCell else {
            return SongTableViewCell()
        }
        guard let info = resultsCount?.results?[indexPath.row] else {
             return SongTableViewCell()
        }
        cell.setup(set: info)


        return cell
    }



    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        //セルの遷移
        let movedate = resultsCount?.results?[indexPath.row]
        let nextView = UIStoryboard(name: "SoundPlayer", bundle: nil).instantiateViewController(identifier: "SoundPlayerViewController") as! SoundPlayerViewController
        nextView.trackName = movedate?.trackName
        nextView.previewUrl = movedate?.previewUrl

        navigationController?.pushViewController(nextView, animated: true)


    }

}

extension UITableView {
    func setEmptyView(title: String, message: String) {
       let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))

        let titleLabel = UILabel()
        let messageLabel = UILabel()

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        messageLabel.textColor = UIColor.lightGray
        messageLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 17)
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)

        titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true

        titleLabel.text = title
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center

        self.backgroundView = emptyView
        self.separatorStyle = .none

    }
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }

}
