//
//  NetworkService.swift
//  iMusic
//
//  Created by Сергей on 16.07.2024.
//

import UIKit
import Alamofire

final class NetworkService {
    
    func fetchTracks(searchText: String, completion: @escaping (SearchResponse?) -> Void) {
        let url = "https://itunes.apple.com/search"
        let parameters = ["term" : "\(searchText)", "limit" : "30",
                          "media" : "music"
        ]
        
        
        AF.request(url, parameters: parameters).responseDecodable(of: SearchResponse.self) { response in
            switch response.result {
            case .success(let objects):
                completion(objects)
            case .failure(_):
                completion(nil)
        }
        }
    }
    
}
