//
//  Items.swift
//  ToDoList
//
//  Created by Uday Kumar Abhishek . (Service Transformation) on 30/04/21.
//

import Foundation

class Item: Encodable, Decodable {
    var name: String = "" 
    var isChecked: Bool = false
}
