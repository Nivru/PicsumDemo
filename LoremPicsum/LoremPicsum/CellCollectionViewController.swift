//
//  CellCollectionViewController.swift
//  LoremPicsum
//
//  Created by XYZ on 23/08/20.
//  Copyright © 2020 XYZ. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CellCollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {

    var picSum = [PicSumData]()
        
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Lorem Picsum"
        parseJSONData()
    }

    // MARK: JSON parsing method

    func parseJSONData() {
        
        let url = URL(string: "https://picsum.photos/list")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error == nil {
                do {
                    self.picSum = try JSONDecoder().decode([PicSumData].self, from: data!)
                } catch {
                    print("DebugErrorLogs Parse error")
                }
                
                print(self.picSum.count)
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
            else {
                print("DebugErrorLogs dataTask error")
            }
            
        }.resume()
    }
    
    
    // MARK: Delegate Methods
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return picSum.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
    
        // Configure the cell
        cell.autherLabel.text = picSum[indexPath.row].author.capitalized
    
        cell.imageView.contentMode = .scaleAspectFill
        let imageLinkString = "https://picsum.photos/300/300?image=\(picSum[indexPath.row].id)"
        cell.imageView.downloaded(from: imageLinkString)
        
        return cell
    }
    
}
