//
//  GifDataSource.swift
//  GiphySearch
//
//  Created by Isaac Maupin on 8/13/20.
//  Copyright © 2020 Isaac Maupin. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class GIFDataSoucre: NSObject, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gifs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GifCollectionViewCell", for: indexPath) as! GIFCollectionViewCell
        cell.isSelected = false
        collectionView.deselectItem(at: indexPath, animated: false)
        
        let gif = gifs[indexPath.row]
        
        if let smallGif = gif.images["downsized_medium"] {
            if  let url = smallGif["url"]  {
        
        let imageURL = URL(string: url)
        
        cell.gifView.kf.setImage(with: imageURL)
        return cell
            }
        }
        
        cell.gifView.image = UIImage(named: "MSNBC")
        return cell
        
    }
   
    var gifs = [GIF]()
    
}



