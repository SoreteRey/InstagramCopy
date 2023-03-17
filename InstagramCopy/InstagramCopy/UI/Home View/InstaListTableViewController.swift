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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "instasCell", for: indexPath) as? InstaListTableViewCell else { return UITableViewCell() }
        
        let insta = viewModel.instas[indexPath.row]
        cell.configureCell(with: insta)
        
        return cell
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.delete(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? InstaDetailViewController else { return }
        
        if segue.identifier == "toDetailVC" {
            
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let insta = viewModel.instas[indexPath.row]
            destination.viewModel = InstaDetailViewModel(insta: insta, delegate: destination.self)
        } else {
            destination.viewModel = InstaDetailViewModel(delegate: destination.self)
        }
    }
    // MARK: - Actions
    @IBAction func signOutButtonTapped(_ sender: Any) {
        let iKnowIShouldNotDoThis = UserAccountViewModel()
        iKnowIShouldNotDoThis.signOut()
    }
    
    
}

// MARK: - Extension
extension InstaListTableViewController: InstaListViewModelDelegate {
    func instasLoadedSuccessFully() {
        tableView.reloadData()
    }
}
