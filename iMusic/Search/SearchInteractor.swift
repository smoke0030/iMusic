//
//  SearchInteractor.swift
//  iMusic
//
//  Created by Сергей on 16.07.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SearchBusinessLogic {
  func makeRequest(request: Search.Model.Request.RequestType)
}

class SearchInteractor: SearchBusinessLogic {

var networkService = NetworkService()
  var presenter: SearchPresentationLogic?
  var service: SearchService?
  
  func makeRequest(request: Search.Model.Request.RequestType) {
    if service == nil {
      service = SearchService()
    }
      
      switch request {
          
      case .some:
          print("interactor .some")
          presenter?.presentData(response: Search.Model.Response.ResponseType.some)
      case .getTracks(let searchText):
          networkService.fetchTracks(searchText: searchText) { [weak self] response in
              self?.presenter?.presentData(response: Search.Model.Response.ResponseType.presentTracks(searchResponse: response))
          }
          
      }
  }
  
}
