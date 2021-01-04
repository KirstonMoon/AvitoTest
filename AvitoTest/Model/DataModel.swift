//
//  DataModel.swift
//  AvitoTest
//
//  Created by Kirill Magerya on 03.01.2021.
//

import Foundation

struct DataResponse: Decodable {
    var status: String
    var result: DataResult
}

struct DataResult: Decodable {
    var title, actionTitle, selectedActionTitle: String
    var list: [List]
}

struct List: Decodable {
    var id, title: String
    var listDescription: String?
    var icon: Icon
    var price: String
    var isSelected: Bool

    enum CodingKeys: String, CodingKey {
        case id, title
        case listDescription = "description"
        case icon, price, isSelected
    }
}

struct Icon: Decodable {
    var the52X52: String

    enum CodingKeys: String, CodingKey {
        case the52X52 = "52x52"
    }
}
