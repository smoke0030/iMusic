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
          case getTracks(searchText: String)
      }
    }
    struct Response {
      enum ResponseType {
          case presentTracks(searchResponse: SearchResponse?)
          case presentFooterView
      }
    }
    struct ViewModel {
      enum ViewModelData {
          case displayTracks(searchViewModel: SearchViewModel)
          case displayFooterView
      }
    }
  }
  
}

struct SearchViewModel {
    struct Cell: TrackCellViewModel {
        
        let iconUrlString: String?
        let trackName: String
        let collectionName: String
        let artistName: String
        let previewUrl: String?
    }
    
    let cells: [Cell]
}
