//
//  FeedUploadModel.swift
//  Catstagram
//
//  Created by 김유빈 on 2022/05/12.
//

struct FeedUploadModel : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : FeedUploadResult?
}

struct FeedUploadResult : Decodable {
    var postIdx : Int?
}

