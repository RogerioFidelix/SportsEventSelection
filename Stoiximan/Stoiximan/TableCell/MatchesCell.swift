//
//  MatchesCell.swift
//  Stoiximan
//
//  Created by Rogério Fidelix on 08/10/2023.
//

import Foundation
import UIKit

class MatchesCell: UITableViewCell {
    
    @IBOutlet var collectionView: UICollectionView!
    
    fileprivate var cellViewModel: MatchesCellViewModel?
    
    public func injectMatches(cellViewModel: MatchesCellViewModel?) {
        self.cellViewModel = cellViewModel
        self.collectionView.reloadData()
    }
}

extension MatchesCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return cellViewModel?.cellForRow(collectionView: collectionView, indexPath: indexPath) ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModel?.numberOfItems() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        cellViewModel?.didSelectItem(collectionView: collectionView, indexPath: indexPath)
    }
}

extension MatchesCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellViewModel?.collectionLayout(collectionView: collectionView) ?? CGSize()
    }
}
