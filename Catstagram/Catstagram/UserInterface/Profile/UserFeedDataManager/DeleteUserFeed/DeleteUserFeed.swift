//
//  DeleteUserFeed.swift
//  Catstagram
//
//  Created by 김유빈 on 2022/05/15.
//

import Foundation

struct DeleteUserFeed: Decodable {
    let isSuccess: Bool?
    let code: Int?
    let message: String?
    let result: String?
}
