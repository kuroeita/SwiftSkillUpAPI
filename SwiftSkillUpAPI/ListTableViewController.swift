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
                print("アクセスに失敗しました:\(error)")

            }

        }


    }



    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
