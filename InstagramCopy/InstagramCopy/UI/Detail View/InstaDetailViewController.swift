//
//  InstaDetailViewController.swift
//  InstagramCopy
//
//  Created by Sebastian Guiscardo on 3/15/23.
//

import UIKit

class InstaDetailViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var instaNameTextField: UITextField!
    @IBOutlet weak var instaImageView: UIImageView!
    @IBOutlet weak var instaCommentTextField: UITextField!
    
    // MARK: - Properties
    var viewModel: InstaDetailViewModel!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        

    }
    
    // MARK: - Actions
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = instaNameTextField.text,
              let comment = instaCommentTextField.text,
              let image = instaImageView.image else { return }
    }
    
    viewModel.save()
    
    
}
