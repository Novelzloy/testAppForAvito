//
//  Model.swift
//  testAppForAvito
//
//  Created by Роман on 03.09.2021.
//


import Foundation

class CurrentData {
    var currentDataData: CurrentDataData?
    
    init?(currentDataData: CurrentDataData?) {
        self.currentDataData = currentDataData
    }
}

struct Employee : Decodable {
    var name: String
    var phone_number: String
    var skills: [String]
}

struct Company : Decodable {
    var name: String
    var employees: [Employee]
}

struct CurrentDataData : Decodable {
    var company: Company
}
