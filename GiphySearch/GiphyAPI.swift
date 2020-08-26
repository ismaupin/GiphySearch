//
//  GiphyAPI.swift
//  GiphySearch
//
//  Created by Isaac Maupin on 8/14/20.
//  Copyright © 2020 Isaac Maupin. All rights reserved.
//

import Foundation

struct GiphyAPI {
    
    private let baseURL:String = "https://api.giphy.com/v1/"
    private let apiKey: String = "api_key=yvppOwTUJv2YuhMqDioFucT3XqmNg893"
    private let endPoint: String = "gifs/search?"
    let searchTerm: String
    private let tailParams: String = "&limit=100&offset=0&rating=g&lang=en"
    let fullURL: URL
    init(searchTerm: String) {
        self.searchTerm = searchTerm
        let urlString = baseURL + endPoint + apiKey + "&q=" + searchTerm + tailParams
        self.fullURL = URL(string: urlString)!
    }
    
}
