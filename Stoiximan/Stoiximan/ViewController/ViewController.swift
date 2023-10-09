//
//  ViewController.swift
//  Stoiximan
//
//  Created by Rogério Fidelix on 08/10/2023.
//

import UIKit

public protocol CellSelected {
    func seletect()
}

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
        navigationController?.navigationBar.backgroundColor = viewModel.navBarColor
        self.viewModel.callAPI(tableView: tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource  {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sportCells.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.cellForRow(tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionHeaderView = viewModel.setupTableViewHeader(section: section, view: view!)
        
        let tap = UITapGestureRecognizer(target: self, action:#selector(self.hideSection(_:)))
        sectionHeaderView.addGestureRecognizer(tap)
        
        return sectionHeaderView
    }
    
    @objc
    private func hideSection(_ sender: UITapGestureRecognizer) {
        let newSection = sender.view!.tag
        
        if(newSection != viewModel.openSection) {
            
            var sectionArray: [Int] = [viewModel.openSection]
            sectionArray.append(newSection)
            viewModel.openSection = newSection
            
            let indices: IndexSet = IndexSet(sectionArray)
            tableView.reloadSections(indices, with: .automatic)
            
        }
    }
}
