//
//  SearchModels.swift
//  iMusic
//
//  Created by Сергей on 16.07.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum Search {
   
  enum Model {
    struct Request {
      enum RequestType {
        case some
          case getTracks(searchText: String)
      }
    }
    struct Response {
      enum ResponseType {
        case some
          case presentTracks(searchResponse: SearchResponse?)
      }
    }
    struct ViewModel {
      enum ViewModelData {
        case some
          case displayTracks(searchViewModel: SearchViewModel)
      }
    }
  }
  
}

struct SearchViewModel {
    struct Cell {
        let iconUrlString: String?
        let trackName: String
        let coolectionName: String
        let artistName: String
    }
    
    let cells: [Cell]
}
