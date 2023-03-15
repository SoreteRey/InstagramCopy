//
//  FirebaseService.swift
//  InstagramCopy
//
//  Created by Sebastian Guiscardo on 3/14/23.
//

import Foundation
import FirebaseFirestore

enum FirebaseError: Error {
    case firebaseError(Error)
    case failedToUnwrapData
    case noDataFound
}

protocol FireBaseSyncable {
    func save(insta: Insta)
    func loadInstas(completion: @escaping (Result<[Insta], FirebaseError>) -> Void)
    func delete(insta: Insta)
}

struct FirebaseService: FireBaseSyncable {
    
    let ref = Firestore.firestore()
    
    func save(insta: Insta) {
        ref.collection(Insta.Key.collectionType).document(insta.uuid).setData(insta.dictionaryRepresentation)
    }
    
    func loadInstas(completion: @escaping (Result<[Insta], FirebaseError>) -> Void) {
        ref.collection(Insta.Key.collectionType).getDocuments { snapshot, error in
            if let error {
                print(error.localizedDescription)
                completion(.failure(.firebaseError(error)))
                return
            }
            
            guard let docSnapshotArray = snapshot?.documents else {
                completion(.failure(.noDataFound))
                return
            }
            
            let dictionaryArray = docSnapshotArray.compactMap { $0.data() }
            let instas = dictionaryArray.compactMap { Insta(fromDictionary: $0) }
            completion(.success(instas))
        }
    }
    
    func delete(insta: Insta) {
        ref.collection(Insta.Key.collectionType).document(insta.uuid).delete()
    }
}
