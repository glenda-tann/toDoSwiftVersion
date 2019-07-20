//
//  toDos.swift
//  toDo Swift Version
//
//  Created by Zoe Tse on 13/7/19.
//  Copyright © 2019 Zoe Tse. All rights reserved.
//

import Foundation
import UIKit


class contentsToDos: Codable {
    
    enum CodingKeys: String, CodingKey {
        case item
        case description
        case category
        case date
        case doneOrNot
        case image
    }
    

    var item: String
    var description: String
    var date: Date
    var category: String
    var doneOrNot: Bool
    var image: UIImage!
    
    init(item: String, description: String, date: Date, category: String, doneOrNot: Bool, image: UIImage!){
        self.item = item
        self.description = description
        self.date = date
        self.category = category
        self.doneOrNot = doneOrNot
        self.image = image
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        item = try container.decode(String.self, forKey: .item)
        description = try container.decode(String.self, forKey: .description)
        date = try container.decode(Date.self, forKey: .date)
        category = try container.decode(String.self, forKey: .category)
        doneOrNot = try container.decode(Bool.self, forKey: .doneOrNot)
        
        if let text = try container.decodeIfPresent(String.self, forKey: .image) {
            if let data = Data(base64Encoded: text) {
                image = UIImage(data: data)
            }
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        if let image = image, let data = image.pngData() {
            try container.encode(data, forKey: .image)
        }
        try container.encode(item, forKey: .item)
        try container.encode(description, forKey: .description)
        try container.encode(date, forKey: .date)
        try container.encode(category, forKey: .category)
        try container.encode(doneOrNot, forKey: .doneOrNot)
    }

    
    static func loadSampleData() -> [contentsToDos] {
        let todos = [contentsToDos(item: "Buy milk", description: "At glenda's shop", date: Date(), category: "", doneOrNot: false, image: UIImage(named: "stella.jpg"))]
        return todos
    }
    
    static func getArchiveURL() -> URL {
        let plistName = "todos"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDirectory.appendingPathComponent(plistName).appendingPathExtension("plist")
    }
    
    static func saveToFile(todos: [contentsToDos]) {
        let archiveURL = getArchiveURL()
        let propertyListEncoder = PropertyListEncoder()
        let encodedtodos = try? propertyListEncoder.encode(todos)
        try? encodedtodos?.write(to: archiveURL, options: .noFileProtection)
    }
    
    static func loadFromFile() -> [contentsToDos]? {
        let archiveURL = getArchiveURL()
        let propertyListDecoder = PropertyListDecoder()
        guard let retrievedToDosData = try? Data(contentsOf: archiveURL) else { return nil }
        guard let decodedToDos = try? propertyListDecoder.decode(Array<contentsToDos>.self, from: retrievedToDosData) else { return nil }
        return decodedToDos
    }
}

//struct Checklist: Codable {
//    enum CodingKeys: String, CodingKey {
//        case item
//        case description
//        case category
//        case date
//        case doneOrNot
//        case image
//    }
//    
//    var item: String
//    var description: String
//    var date: Date
//    var category: String
//    var doneOrNot: Bool
//    var image: UIImage?
//    
//    var items: [contentsToDos] = []
//    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        item = try container.decode(String.self, forKey: .item)
//        description = try container.decode(String.self, forKey: .description)
//        date = try container.decode(Date.self, forKey: .date)
//        category = try container.decode(String.self, forKey: .category)
//        doneOrNot = try container.decode(Bool.self, forKey: .doneOrNot)
//        image = try container.decode(UIImage.self, forKey: .image)
//        
//        if let text = try container.decodeIfPresent(String.self, forKey: .image) {
//            if let data = Data(base64Encoded: text) {
//                image = UIImage(data: data)
//            }
//        }
//    }
//    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        if let image = image, let data = image.pngData() {
//            try container.encode(data, forKey: .image)
//        }
//        try container.encode(item, forKey: .item)
//        try container.encode(description, forKey: .description)
//        try container.encode(date, forKey: .date)
//        try container.encode(category, forKey: .category)
//        try container.encode(doneOrNot, forKey: .doneOrNot)
//        try container.encode(image ?? nil, forKey: .image)
//    }
//}
