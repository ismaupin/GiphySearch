//
//  ViewController.swift
//  GiphySearch
//
//  Created by Isaac Maupin on 8/13/20.
//  Copyright © 2020 Isaac Maupin. All rights reserved.
//

import UIKit
import Kingfisher
class ViewController: UIViewController, UICollectionViewDelegate {

    @IBOutlet var searchButton: UIButton!
    @IBOutlet var searchTextField: UITextField!
    
    @IBOutlet var searchResultsCollectionView: UICollectionView!
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    var collectionViewDataSource = GIFDataSoucre()
    private var cache = SearchCache()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchResultsCollectionView.allowsSelection = true
        searchResultsCollectionView.dataSource = collectionViewDataSource
        collectionViewDataSource.gifs = cache.loadFromCache()
        searchResultsCollectionView.delegate = self
    }

    
    @IBAction func searchButtonTapped(_ sender: Any) {
        collectionViewDataSource.gifs.removeAll()
        guard let searchTerm = searchTextField.text else { return }
        var updatedSearchTerm = ""
        if searchTerm.contains(" ") {
            
            for char in searchTerm {
                if char != " " {
                    updatedSearchTerm.append(char)
                } else {
                    updatedSearchTerm.append("%20")
                }
            }
        } else {
            updatedSearchTerm = searchTerm
        }
        let apiCall = GiphyAPI(searchTerm: updatedSearchTerm)
        let request = URLRequest(url: apiCall.fullURL)
        print(apiCall.fullURL)
        let task = session.dataTask(with: request) {
            (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse,
                (200..<300).contains(httpResponse.statusCode) else { fatalError() }
            guard let data = data else { return}
            self.decodeJSON(data: data, key:searchTerm)
        }
        task.resume()
    }
    
// populate the collectionView with the information

    func decodeJSON(data:Data, key: String) {
      let decoder = JSONDecoder()
      do{ let gifs = try decoder.decode(GIFData.self, from: data)
          print(gifs)
        collectionViewDataSource.gifs += gifs.data
        cache.saveCache(key: key, gifs: gifs.data)
        DispatchQueue.main.async {
            self.searchResultsCollectionView.reloadData()
        }
      } catch {
          print(error.self)
      }
  }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectedGIF" {
        guard let selectedIndex = searchResultsCollectionView.indexPathsForSelectedItems?.first else { return }
            let gif = collectionViewDataSource.gifs[selectedIndex.row]
        
        let destinationVC = segue.destination as! SelectedGifViewController
        guard let images = gif.images["original"],
        let url = images["url"] else { return }
        let imageURL = URL(string: url)
        
        destinationVC.selectedGifImageview.kf.setImage(with: imageURL)
        } else {
            print("Unknown segue")
        }
    }
   
}


