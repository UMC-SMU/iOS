//
//  DeleteUserFeed.swift
//  Catstagram
//
//  Created by 문정호 on 2022/05/19.
//

import Foundation

struct DeleteUserFeed : Decodable{
    let isSuccess: Bool?
    let code: Int?
    let message: String?
    let result: String?
}
