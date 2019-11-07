//
//  API.swift
//  SwiftSkillUpAPI
//
//  Created by 黒川瑛太郎 on 2019/11/01.
//  Copyright © 2019 Eitaro Kurokawa. All rights reserved.
//

import Foundation
import Moya

class Address: Codable {
    var resultCount: Int
    var results: [Result]?
}

struct Result: Codable {
    var artistName: String
    var trackName: String
}


enum ITunesAPI {
    case artistName(request: Dictionary<String, Any>)
}

extension ITunesAPI: TargetType {
   var baseURL:URL {
        return URL(string: "https://itunes.apple.com/search?term=beatles&country=JP&lang=ja_jp&media=music")!
    }

    var path: String {
        switch self {
        case .artistName:
            return "/artistName"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        return .requestPlain
    }

    var headers: [String : String]? {
        return ["content-type": "application/json"]
    }

}

//class SoundInformation: Codable {
//    var status_code: Int
//    var artistName: String
//}
