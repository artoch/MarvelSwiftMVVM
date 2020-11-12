//
//  CharacterDataWrapper.swift
//  testiosapp
//
//  Created by Alfredo Tochon on 11/11/20.
//

import Foundation


struct CharacterDataWrapper:Codable {
    let code:Int
    let status:String
    let data:CharacterDataContainer
    
    
    enum CodingKeys:String, CodingKey{
        case code
        case status
        case data
    }
}

struct CharacterDataContainer:Codable {
    let count:Int
    let total:Int
    let results:[Character]
    
    
    enum CodingKeys:String, CodingKey{
        case count
        case total
        case results
    }
}

struct Character:Codable{
    let id:Int
    let name:String
    let description:String
    let thumbnail:Image
    
    
    enum CodingKeys:String, CodingKey{
        case id
        case name
        case description
        case thumbnail
    }
}

struct Image:Codable {
    let path:String
    let ext:String
    
    enum CodingKeys:String, CodingKey{
        case path
        case ext = "extension"
    }
}

    
