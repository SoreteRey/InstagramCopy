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
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return viewModel.instas.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "instasCell", for: indexPath)

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
