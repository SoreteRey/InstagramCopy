//
//  InstaListViewModel.swift
//  InstagramCopy
//
//  Created by Sebastian Guiscardo on 3/14/23.
//

import Foundation
protocol InstaListViewModelDelegate: AnyObject {
    func instasLoadedSuccessFully()
}

class InstaListViewModel {
    // MARK: - Properties
    var instas: [Insta] = []
    private var service: FireBaseSyncable
    private weak var delegate: InstaListViewModelDelegate?
    
    init(firebaseService: FireBaseSyncable = FirebaseService(), delegate: InstaListViewModelDelegate) {
        self.service = firebaseService
        self.delegate = delegate
    }
    // MARK: - Functions
    func loadData() {
        service.loadInstas { [weak self] result in
            switch result {
            case .success(let instas):
                self?.instas = instas
                self?.delegate?.instasLoadedSuccessFully()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
