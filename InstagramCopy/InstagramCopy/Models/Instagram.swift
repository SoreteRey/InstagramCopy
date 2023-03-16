//
//  Instagram.swift
//  InstagramCopy
//
//  Created by Sebastian Guiscardo on 3/14/23.
//

import UIKit

class Insta {
    
    enum Key {
        static let name = "name"
        static let comment = "comment"
        static let imageURL = "imageURL"
        static let uuid = "uuid"
        static let date = "date"
        static let collectionType = "Instas"
        
    }
    
    // MARK: - Properties
    var InstaName: String
    var InstaComment: String
    var imageURL: String
    var InstaDate: Date
    let uuid: String
    
    var dictionaryRepresentation: [String: AnyHashable] {
        [
            Key.name: self.InstaName,
            Key.comment: self.InstaComment,
            Key.imageURL: self.imageURL,
            Key.date: self.InstaDate.timeIntervalSince1970,
            Key.uuid: self.uuid
        ]
    }
    init(InstaName: String, InstaComment: String, InstaDate: Date = Date(), uuid: String = UUID().uuidString, imageURL: String) {
        
        self.InstaName = InstaName
        self.InstaComment = InstaComment
        self.imageURL = imageURL
        self.InstaDate = InstaDate
        self.uuid = uuid
    }
}

extension Insta {
    convenience init?(fromDictionary dictionary: [String : Any]) {
        guard let name = dictionary[Key.name] as? String,
              let comment = dictionary[Key.comment] as? String,
              let imageURL = dictionary[Key.imageURL] as? String,
              let date = dictionary[Key.date] as? Double,
              let uuid = dictionary[Key.uuid] as? String else { print("Failed to initialize object")
            return nil
            
        }
        self.init(InstaName: name, InstaComment: comment, InstaDate: Date(timeIntervalSince1970: date), uuid: uuid, imageURL: imageURL)
    }
}

extension Insta: Equatable {
    static func == (lhs: Insta, rhs: Insta) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
