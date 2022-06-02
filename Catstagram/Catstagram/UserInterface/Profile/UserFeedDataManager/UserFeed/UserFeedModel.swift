//
//  UserFeedModel.swift
//  Catstagram
//
//  Created by 문정호 on 2022/05/18.
//

import Foundation

struct UserFeedModel : Decodable {
    
    let isSuccess: Bool? //networking을 하다보면 데이터를 못받아올수도 있으니 optional로 선언
    let code: Int?
    let message: String?
    let result: UserFeedModelResult?
    
}

struct UserFeedModelResult: Decodable{
    let _isMyFeed: Bool?
    let getUserInfo: GetUserInfo? //구조체 변수
    let getUserPosts: [GetUserPosts]? //배열 선언
}
    
struct GetUserInfo : Decodable{
    let userIdx: Int?
    let nickName: String?
    let name: String?
    let profileImgUrl: String?
    let website: String?
    let introduction: String?
    let followerCount:Int?
    let followingCount:Int?
    let postCount: Int?
}

struct GetUserPosts: Decodable{
    let postIdx: Int?
    let postImgUrl: String?
}
