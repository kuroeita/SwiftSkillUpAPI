//
//  API.swift
//  SwiftSkillUpAPI
//
//  Created by 黒川瑛太郎 on 2019/11/01.
//  Copyright © 2019 Eitaro Kurokawa. All rights reserved.
//

import Foundation
import Moya


// レスポンスの型
struct NestTitle: Codable {
    var resultCount: Int
    var results: [Result]?
}

struct Result: Codable {
    var artistName: String
    var trackName: String
    var artworkUrl100: URL
    var previewUrl: URL

    init(_ artist: String, _ track: String, _ image: URL, _ preview: URL) {
        self.artistName = artist
        self.trackName = track
        self.artworkUrl100 = image
        self.previewUrl = preview
    }
}
//

enum ITunesAPI {
    case searchInformation(term: String)
}

extension ITunesAPI: TargetType {
   var baseURL:URL {
        return URL(string:"https://itunes.apple.com")!
    }

    // "https://itunes.apple.com/search?term=\(searchText)&country=JP&lang=ja_jp&media=music"
    //BaseURLはあくまでもベースであり、後ろのKey/valueは下記で設定していく


    var path: String {
        switch self {
        case .searchInformation:
            return "/search"
            //Keyを指定する
        }
    }

    var method: Moya.Method {
        return .get
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .searchInformation(let request):
            var params: [String: Any] = [:]
            params["term"] = request
            params["lang"] = "ja_jp"
            params["country"] = "JP"
            params["limit"] = 9999

            //searchInformationはKey/valueをみるところ/パラメーター

            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }

    }

    var headers: [String : String]? {
        return ["content-type": "application/json"]
    }

}

//class SoundInformation: Codable {
//    var status_code: Int
//    var artistName: String
//}
