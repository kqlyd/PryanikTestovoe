//
//  Model.swift
//  PryanikTestovoe
//
//  Created by Denis Zhukov on 15.07.2020.
//  Copyright © 2020 Denis Zhukov. All rights reserved.
//

import Foundation

struct ElementsView: Decodable{
    var data: [Elements]?
    var view: [String]?
}

struct Hz: Decodable {
    var text: String?
}
struct Picture: Decodable {
    var url: String?
    var text: String?
}
struct Selector: Decodable {
    var selectedId: Int?
    var variants: [SelectorVariant]?
}

struct SelectorVariant: Decodable {
    var id: Int?
    var text: String?
}

enum ElementType: String, Decodable{
    case hz
    case picture
    case selector
    case unknown
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let name = try container.decode(String.self)
        self = ElementType(rawValue: name) ?? .unknown
    }
    
}

enum Elements: Decodable {
    case hz(Hz)
    case picture(Picture)
    case selector(Selector)
    case unknown
    
    enum CodingKeys: String, CodingKey {
        case name
        case data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        guard let type = try? container.decode(ElementType.self, forKey: .name) else {
            self = .unknown
            return
        }
        switch type {
        case .hz:
            let hz = try container.decode(Hz.self, forKey: .data)
            self = .hz(hz)
        case .picture:
            let picture = try container.decode(Picture.self, forKey: .data)
            self = .picture(picture)
        case .selector:
            let selector = try container.decode(Selector.self, forKey: .data)
            self = .selector(selector)
        case .unknown:
            self = .unknown
        }
    }
}


