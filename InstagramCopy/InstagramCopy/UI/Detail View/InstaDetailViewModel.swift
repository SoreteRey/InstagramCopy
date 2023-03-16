//
//  InstaDetailViewModel.swift
//  InstagramCopy
//
//  Created by Sebastian Guiscardo on 3/15/23.
//

import UIKit
import FirebaseFirestore

protocol InstaDetailViewModelDelegate: AnyObject {
    func imageSuccessfullySaved()}

struct InstaDetailViewModel {
    
    // MARK: - Properties
    var insta: Insta?
    let service: FireBaseSyncable
    private weak var delegate: InstaDetailViewModelDelegate?
    init(insta: Insta? = nil, serviceInjected: FireBaseSyncable = FirebaseService(), delegate: InstaDetailViewModelDelegate) {
        self.insta = insta
        service = serviceInjected
        self.delegate = delegate
    }
    
    // MARK: - Functions
    
    func save(name: String, comment: String, image: UIImage) {
        if let insta {
            insta.InstaName = name
            insta.InstaComment = comment
            service.update(insta, with: image) {
                self.delegate?.imageSuccessfullySaved()
            }
        } else {
            service.save(name: name, comment: comment, image: image) {
                self.delegate?.imageSuccessfullySaved()
            }
        }
    }
    
    func getImage(completion: @escaping (UIImage?) -> Void) {
        guard let insta = insta else { return }
        service.fetchImage(from: insta) { result in
            switch result {
            case .success(let image):
                completion(image)
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
}
