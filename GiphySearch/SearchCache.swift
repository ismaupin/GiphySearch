//
//  SearchCache.swift
//  GiphySearch
//
//  Created by Isaac Maupin on 8/26/20.
//  Copyright © 2020 Isaac Maupin. All rights reserved.
//

import Foundation
import UIKit
struct SearchCache {
    
    private var gifCache = [String: [GIF]]()
      
        
    
   mutating func saveCache(key: String, gifs:[GIF]) {
    if gifCache.isEmpty {
    gifCache.updateValue(gifs, forKey: key)
    } else {
        gifCache.removeAll()
        gifCache.updateValue(gifs, forKey: key)
    }
        let encoder = PropertyListEncoder()
        
    do { let data = try encoder.encode(gifCache)
        UserDefaults.standard.set(data, forKey: "gifCache")
    } catch {
        print("Error encoding data: \(error)")
    }
        
        
    }
    
    func loadFromCache() -> [GIF] {
        let decoder = PropertyListDecoder()
        guard let data = UserDefaults.standard.data(forKey: "gifCache") else {return []}
        do { let cache = try decoder.decode([String: [GIF]].self, from: data )
            guard let firstElement = cache.first else { return []}
            return firstElement.value
        } catch {
            print("Error decoding cache: \(error)")
            return []
        }
    }
}
