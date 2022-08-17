//
//  DataService.swift
//  RedditTest
//
//  Created by Gabriel Lupu on 09.06.2022.
//

import UIKit
import Alamofire
import SwiftyJSON

class DataService {

    static let shared = DataService()

    var BASE_HOST : String {
        get {
            return "https://rickandmortyapi.com/api/character/"
        }
    }

    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }

    internal func call(endpointUrl url:String, completion: @escaping (JSON?, Error?) -> Void) {
        Alamofire.request(url).responseJSON { response in
            switch response.result {
            case .success(let value):
                completion(JSON(value), nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }

    func getData(page: Int, completion: @escaping (GeneralCharacterInformation?, Error?) -> Void) {

        var suffix = ""
        if page > 0 {
            suffix = "?page=\(page)"
        }

        self.call(endpointUrl: "\(BASE_HOST)\(suffix)") { json, error in
            if let json = json, let data = GeneralCharacterInformation(json: json) {
                completion(data, nil)
            } else {
                completion(nil, error)
            }
        }
    }

}
