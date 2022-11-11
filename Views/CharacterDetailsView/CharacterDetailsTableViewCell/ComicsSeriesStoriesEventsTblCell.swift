//
//  ComicsSeriesStoriesEventsTblCell.swift
//  Marvel
//
//  Created by Mac on 11/11/2022.
//  Copyright © 2022 Aly Fawzy. All rights reserved.
//

import UIKit

class ComicsSeriesStoriesEventsTblCell: UITableViewCell {

    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var ComicsSeriesStoriesEventsCollection: UICollectionView!
    
    var arrItems: [characterResourcesDataResults] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        setupAndRegisterCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   private func setupAndRegisterCell() {
       ComicsSeriesStoriesEventsCollection.delegate = self
       ComicsSeriesStoriesEventsCollection.dataSource = self
        ComicsSeriesStoriesEventsCollection.register(CharacterDetailsCollectionViewCell.nib, forCellWithReuseIdentifier: CharacterDetailsCollectionViewCell.identifier)
    }
}


// MARK: - UICollectionViewDelegate, DataSource
extension ComicsSeriesStoriesEventsTblCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrItems.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (ComicsSeriesStoriesEventsCollection.frame.width/3.5), height: ComicsSeriesStoriesEventsCollection.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterDetailsCollectionViewCell.identifier, for: indexPath) as! CharacterDetailsCollectionViewCell
        
        let imageUrl = (arrItems[indexPath.row].thumbnail?.path ?? "") + "." + (arrItems[indexPath.row].thumbnail?.thumbnailExtension ?? "")
        cell.itemImage.setImageWith(stringUrl: imageUrl,placeholder: UIImage(named: "image_not_available"))
        cell.itemName.text = arrItems[indexPath.row].title
            return cell
    }
}
