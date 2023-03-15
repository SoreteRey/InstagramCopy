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
        static let profImage = "profImage"
        static let mainImage = "mainImage"
        static let uuid = "uuid"
        static let date = "date"
        static let collectionType = "Instas"
    }
    
    // MARK: - Properties
    var InstaName: String
    var InstaComment: String
    var InstaProfImage: UIImage
    var InstaMainImage: UIImage
    var InstaDate: Date
    let uuid: String
    
    var dictionaryRepresentation: [String: AnyHashable] {
        [
            Key.name: self.InstaName,
            Key.comment: self.InstaComment,
            Key.profImage: self.InstaProfImage,
            Key.mainImage: self.InstaMainImage,
            Key.date: self.InstaDate.timeIntervalSince1970,
            Key.uuid: self.uuid
        ]
    }
    init(InstaName: String, InstaComment: String, InstaProfImage: UIImage, InstaMainImage: UIImage, InstaDate: Date = Date(), uuid: String = UUID().uuidString) {
        
        self.InstaName = InstaName
        self.InstaComment = InstaComment
        self.InstaProfImage = InstaProfImage
        self.InstaMainImage = InstaMainImage
        self.InstaDate = InstaDate
        self.uuid = uuid
    }
}
extension Insta {
    convenience init?(fromDictionary dictionary: [String : Any]) {
        guard let name = dictionary[Key.name] as? String,
              let comment = dictionary[Key.comment] as? String,
              let profImage = dictionary[Key.profImage] as? UIImage,
              let mainImage = dictionary[Key.mainImage] as? UIImage,
              let date = dictionary[Key.date] as? Double,
              let uuid = dictionary[Key.uuid] as? String else { print("Failed to initialize object")
            return nil
            
        }
        self.init(InstaName: name, InstaComment: comment, InstaProfImage: profImage, InstaMainImage: mainImage, InstaDate: Date(timeIntervalSince1970: date), uuid: uuid)
    }
}

extension Insta: Equatable {
    static func == (lhs: Insta, rhs: Insta) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
