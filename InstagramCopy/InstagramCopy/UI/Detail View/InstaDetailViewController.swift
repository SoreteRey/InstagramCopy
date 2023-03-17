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
        
        viewModel.save(name: name, comment: comment, image: image)
    }
    
    
    // MARK: - Helper Functions
    
    private func updateUI() {
        guard let insta = viewModel.insta else { return }
        instaNameTextField.text = insta.InstaName
        instaCommentTextField.text = insta.InstaComment
        
        viewModel.getImage { image in
            self.instaImageView.image = image
        }
    }
    
    func setUpImageView() {
        instaImageView.contentMode = .scaleAspectFit
        instaImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        instaImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc func imageViewTapped() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
}

// MARK: - Extension
extension InstaDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        instaImageView.image = image
    }
}
    // MARK: - InstaDetailViewModelDelegate
extension InstaDetailViewController: InstaDetailViewModelDelegate {
    func imageSuccessfullySaved() {
        self.navigationController?.popViewController(animated: true)
    }
}
