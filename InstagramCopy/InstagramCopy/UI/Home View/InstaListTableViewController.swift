//
//  InstaListTableViewController.swift
//  InstagramCopy
//
//  Created by Sebastian Guiscardo on 3/14/23.
//

import UIKit

class InstaListTableViewController: UITableViewController {

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = InstaListViewModel(delegate: self)

       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadData()
    }
    
    // MARK: - Properties
    var viewModel: InstaListViewModel!

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.instas.count
    }
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "instasCell", for: indexPath) as? Insta

        // Configure the cell...

        return cell
    }
}

// MARK: - Extension
extension InstaListTableViewController: InstaListViewModelDelegate {
    func instasLoadedSuccessFully() {
        tableView.reloadData()
    }
}
