//
//  File.swift
//  GiphySearch
//
//  Created by Isaac Maupin on 8/13/20.
//  Copyright © 2020 Isaac Maupin. All rights reserved.
//

import Foundation

struct GIFData: Codable {
    let data: [GIF]
}

struct GIF: Codable {
    let id: String
    let images: [String:[String: String]]
}


