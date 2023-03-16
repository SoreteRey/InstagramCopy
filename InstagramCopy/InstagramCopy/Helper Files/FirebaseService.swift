//
//  FirebaseService.swift
//  InstagramCopy
//
//  Created by Sebastian Guiscardo on 3/14/23.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

enum FirebaseError: Error {
    case firebaseError(Error)
    case failedToUnwrapData
    case noDataFound
}

protocol FireBaseSyncable {
    func save(name: String, comment: String, image: UIImage, completion: @escaping () -> Void)
    func loadInstas(completion: @escaping (Result<[Insta], FirebaseError>) -> Void)
    func delete(insta: Insta)
    func saveImage(_ image: UIImage, with uuidString: String, completion: @escaping (Result<URL, FirebaseError>) -> Void)
    func fetchImage(from insta: Insta, completion: @escaping (Result<UIImage, FirebaseError>) -> Void)
    func deleteImage(from insta: Insta)
    func update(_ insta: Insta, with newImage: UIImage, completion: @escaping () -> Void)
}

struct FirebaseService: FireBaseSyncable {
    
    // MARK: - Properties
    let ref = Firestore.firestore()
    let storage = Storage.storage().reference()
    
    // MARK: - Functions
    
    func save(name: String, comment: String, image: UIImage, completion: @escaping () -> Void) {
        
        let uuid = UUID().uuidString
        
        saveImage(image, with: uuid) { result in
            switch result {
            case .success(let imageURL):
                let insta = Insta(InstaName: name, InstaComment: comment, uuid: uuid, imageURL: imageURL.absoluteString)
                ref.collection(Insta.Key.collectionType).document(insta.uuid).setData(insta.dictionaryRepresentation)
                completion()
            case .failure(let failure):
                print(failure)
                return
            }
        }
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
        deleteImage(from: insta)
    }
    
    func saveImage(_ image: UIImage, with uuidString: String, completion: @escaping (Result<URL, FirebaseError>) -> Void) {
        
        guard let imageData = image.jpegData(compressionQuality: 0.05) else { return }
        
        let uploadMetadata = StorageMetadata()
        uploadMetadata.contentType = "image/jpeg"
        
        let uploadTask = storage.child(Constants.Insta.ImageRef).child(uuidString).putData(imageData, metadata: uploadMetadata) {
            _, error in
            
            if let error {
                print(error.localizedDescription)
                completion(.failure(.firebaseError(error)))
                return
            }
        }
        
        uploadTask.observe(.success) { _ in
            print("uploaded image")
            storage.child(Constants.Insta.ImageRef).child(uuidString).downloadURL { url, error in
                if let error {
                    print(error.localizedDescription)
                    completion(.failure(.firebaseError(error)))
                    return
                }
                
                if let url {
                    print("Image URL: \(url)")
                    completion(.success(url))
                }
            }
        }
        uploadTask.observe(.failure) { snapshot in
            completion(.failure(.firebaseError(snapshot.error!)))
            return
        }
    }
    
    func fetchImage(from insta: Insta, completion: @escaping (Result<UIImage, FirebaseError>) -> Void) {
        storage.child(Constants.Insta.ImageRef).child(insta.uuid).getData(maxSize: 1024 * 1024) { result in
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else {
                    completion(.failure(.failedToUnwrapData))
                    return
                }
                completion(.success(image))
            case .failure(let error):
                completion(.failure(.firebaseError(error)))
                return
            }
        }
    }
    
    func deleteImage(from insta: Insta) {
        storage.child(Constants.Insta.ImageRef).child(insta.uuid).delete(completion: nil)
    }
    
    func update(_ insta: Insta, with newImage: UIImage, completion: @escaping () -> Void) {
        saveImage(newImage, with: insta.uuid) { result in
            switch result {
            case .success(let imageURL):
                insta.imageURL = imageURL.absoluteString
                ref.collection(Insta.Key.collectionType).document(insta.uuid).setData(insta.dictionaryRepresentation)
                completion()
            case .failure(let failure):
                print(failure)
                return
            }
        }
    }
}
