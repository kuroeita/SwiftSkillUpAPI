//
//  ListTableViewController.swift
//  SwiftSkillUpAPI
//
//  Created by 黒川瑛太郎 on 2019/11/04.
//  Copyright © 2019 Eitaro Kurokawa. All rights reserved.
//

import UIKit
import Moya

class ListTableViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    private var results: [NSDictionary]?


    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UINib(nibName: "SongTableViewCell", bundle: nil), forCellReuseIdentifier: "SongTableViewCell")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        let provider = MoyaProvider<ITunesAPI>()
        provider.request( .artistName(request: ["artistName": "ビートルズ"])) { results in
            switch results {
            case let .success(moyaResponse):
                let jsonData = try? JSONDecoder().decode(Address.self, from: moyaResponse.data)
                dump(jsonData!)
            case let .failure(error):
                print("アクセスに失敗しました:\(error)")



//                do {
//                    let date = try moyaResponse.mapJSON()
//                    print(date)
//                    let jsonDate = try? JSONDecoder().decode(SoundInformation.self, from: moyaResponse.data)
//                    print(jsonDate!.artistName)
//                }
//                catch {
//                    print("json prese失敗")
//                }
//            case let .failure(error):
//                print("アクセスに失敗しました:\(error)")
            }

        }

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
