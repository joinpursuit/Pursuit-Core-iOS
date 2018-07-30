//
//  AlbumCollectionViewController.swift
//  SpotifyGrid
//
//  Created by Jason Gresh on 10/30/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

fileprivate let reuseIdentifier = "AlbumCell"
fileprivate let itemsPerRow: CGFloat = 3

class AlbumCollectionViewController: UICollectionViewController, UITextFieldDelegate, UICollectionViewDelegateFlowLayout {
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    
    var albums: [Album] = []
    let searchTerm = "blue"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "No Search Yet"
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.albums.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        if let acvc = cell as? AlbumCollectionViewCell {
            let album = self.albums[indexPath.row]
            acvc.titleLabel.text = "\(indexPath.row + 1). \(album.name)"
            
            if album.images.count > 1 {
                APIRequestManager.manager.getData(endPoint: album.images[1].url.absoluteString) { (data: Data?) in
                    if let validData = data,
                        let image = UIImage(data: validData) {
                        DispatchQueue.main.async {
                            acvc.imageView.image = image
                            acvc.setNeedsLayout()
                        }
                    }
                }
            }
        }

        return cell
    }

    // MARK: - TextField Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        search(textField.text!)
        textField.text = nil
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - Utility
    func search(_ term: String) {
        self.title = term
        let escapedString = term.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)

        APIRequestManager.manager.getData(endPoint: "https://api.spotify.com/v1/search?q=\(escapedString!)&type=album&limit=50") { (data: Data?) in
            if  let validData = data,
                let validAlbums = Album.albums(from: validData) {
                self.albums = validAlbums
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
            }
        }
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }

    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    // margin around the whole section
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // spacing between rows if vertical / columns if horizontal
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
