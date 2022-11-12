//
//  AnyType.swift
//  Marvel
//
//  Created by Mac on 08/11/2022.
//  Copyright © 2022 Aly Fawzy. All rights reserved.
//

import Foundation

struct AnyType {
    
    private(set) var string: String?
    private(set) var int: Int?
    private(set) var double: Double?
    private(set) var float: Float?
    private(set) var stringArr: [String]?
    private(set) var intArr: [Int]?
    private(set) var doubleArr: [Double]?
    private(set) var floatArr: [Float]?
    
    init(value: String?) {
        self.string = value
    }
    
    init(value: Int?) {
        self.int = value
    }
    
    init(value: Double?) {
        self.double = value
    }
    
    init(value: Float?) {
        self.float = value
    }
    
    init(value: [String]?) {
        self.stringArr = value
    }
    
    init(value: [Int]?) {
        self.intArr = value
    }
    
    init(value: [Double]?) {
        self.doubleArr = value
    }
    
    init(value: [Float]?) {
        self.floatArr = value
    }
}


extension AnyType: Decodable {
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.singleValueContainer()
        
        if let value = try? container.decode(String.self) {
            self.string = value
        } else if let value = try? container.decode(Int.self) {
            self.int = value
        } else if let value = try? container.decode(Double.self) {
            self.double = value
        } else if let value = try? container.decode(Float.self) {
            self.float = value
        } else if let value = try? container.decode([String].self) {
            self.stringArr = value
        } else if let value = try? container.decode([Int].self) {
            self.intArr = value
        } else if let value = try? container.decode([Double].self) {
            self.doubleArr = value
        } else if let value = try? container.decode([Float].self) {
            self.floatArr = value
        } else {
            throw DecodingError.typeMismatch(
                AnyType.self,
                .init(codingPath: [], debugDescription: "Can`t find any matched type")
            )
        }
        
    }
}

extension AnyType: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        if let value = string {
            try container.encode(value)
        } else if let value = int {
            try container.encode(value)
        } else if let value = double {
            try container.encode(value)
        } else if let value = float {
            try container.encode(value)
        } else if let value = stringArr {
            try container.encode(value)
        } else if let value = intArr {
            try container.encode(value)
        } else if let value = doubleArr {
            try container.encode(value)
        } else if let value = floatArr {
            try container.encode(value)
        } else {
            try container.encodeNil()
        }
    }
}
