//
//  Users.swift
//  JSONRESTful
//
//  Created by MacBook Pro on 21/06/23.
//

import Foundation
struct Users:Decodable {
    let id:Int
    let nombre:String
    let clave:String
    let email:String
}
