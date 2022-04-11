//
//  Constants.swift
//  testiosapp
//
//  Created by Alfredo Tochon on 11/11/20.
//

import Foundation
import CryptoSwift

struct Constants {
    static let PUBLIC_API_KEY = ""
    static let PRIVATE_API_KEY = ""
    static let TIMESTAMP = "\(Date().timeIntervalSince1970)"
    static let HASH = (TIMESTAMP + PRIVATE_API_KEY + PUBLIC_API_KEY).md5()
    
    struct Main {
        static let URL_MAIN = "https://gateway.marvel.com/v1/public/"
    }
    
    struct EndPoints {
        static let URL_CHARACTERS = "characters"
    }
}
