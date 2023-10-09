//
//  ViewModel.swift
//  Stoiximan
//
//  Created by Rogério Fidelix on 09/10/2023.
//

import Foundation
import UIKit

class ViewModel {
    
    var openSection: Int = 0
    var sportCells: [Sports] = []
    
    public var title: String {
        return "Stoiximan"
    }
    
    public var navBarColor: UIColor {
        return .white
    }
    
    public func callAPI(tableView: UITableView) {
        SportsAPI().fetchSports { sports in
            self.sportCells = sports
            
            DispatchQueue.main.async {
                tableView.reloadData()
            }
        }
    }
    
    public func numberOfRowsInSection(section: Int) -> Int {
        if section == openSection {
            return 1
        }
        else {
            return 0
        }
    }
    
    public func setupTableViewHeader(section: Int, view: UIView) -> UIView {
        let sectionView = UIView()
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        sectionView.addSubview(label)
        
        let views = ["sectionView": view, "label" : label]
        var allConstraints: [NSLayoutConstraint] = []
        allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|[label(50)]|", options: [], metrics: nil, views: views as [String : Any])
        allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-[label]|", options: [], metrics: nil, views: views as [String : Any])
        NSLayoutConstraint.activate(allConstraints)
        
        sectionView.backgroundColor = .darkGray
        
        sectionView.tag = section
        
        if section < sportCells.count  {
            var prefix = "-"
            if section == openSection {
                prefix = "+"
            }
            
            let sectionName = "\(prefix) \(sportCells[section].d)"
            label.text = sectionName
            return sectionView
        }
        return sectionView
    }
    
    public func cellForRow(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "matchesCell") as? MatchesCell else { return UITableViewCell() }
        
        let cellViewModel = MatchesCellViewModel(matches: sportCells[indexPath.section].e)
        cell.injectMatches(cellViewModel: cellViewModel)
        
        return cell
    }
}
