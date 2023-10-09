//
//  MatchesCellViewModel.swift
//  Stoiximan
//
//  Created by Rogério Fidelix on 09/10/2023.
//

import Foundation
import UIKit

class MatchesCellViewModel {
    
    var matches: [Matches]
    
    public init(matches: [Matches]) {
        self.matches = matches
    }
    
    public func cellForRow(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "matchesCollection", for: indexPath) as? MatchesCollection else { return UICollectionViewCell() }
        
        let date = Date(timeIntervalSince1970: TimeInterval(matches[indexPath.row].tt))

        cell.setupDate(receivadeDate: date)
        if matches[indexPath.row].isSelected ?? false {
            cell.favouritesImageView.image = UIImage(named: "yellowStar")
        } else {
            cell.favouritesImageView.image = UIImage(named: "emptyStarShape")
        }
        cell.teamsLabel.text = matches[indexPath.row].d
        
        return cell
    }
    
    public func numberOfItems() -> Int {
        return matches.count
    }
    
    public func didSelectItem(collectionView: UICollectionView, indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? MatchesCollection
        
        if matches[indexPath.row].isSelected == false || matches[indexPath.row].isSelected == nil {
            matches[indexPath.row].isSelected = true
            cell?.favouritesImageView.image = UIImage(named: "yellowStar")
            
            let movedCell = matches.remove(at: indexPath.row)
            matches.insert(movedCell, at: 0)
            
            collectionView.moveItem(at: indexPath, to: IndexPath(row: 0, section: indexPath.section))
        } else {
            matches[indexPath.row].isSelected = false
            cell?.favouritesImageView.image = UIImage(named: "emptyStarShape")
        }
    }
    
    public func collectionLayout(collectionView: UICollectionView) -> CGSize {
        
        let itemsPerRow: CGFloat = 4
        let hardCodedPadding: CGFloat = 4
        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
        
        return CGSize(width: itemWidth, height: 192.0)
    }
}
