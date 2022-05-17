//
//  UserFeedModel.swift
//  Catstagram
//
//  Created by 문정호 on 2022/05/18.
//

import Foundation

struct UserFeedModel : Decodable {
    {
        isSuccess: Bool?,
        code: Int?,
        message: Sting?,
        ""result"": {
            ""isMyFeed"": true,
            ""userInfo"": {
                ""userIdx"": 2,
                ""nickName"": ""wise._.Beanie"",
                ""name"": ""박현빈"",
                ""profileImgUrl"": ""finnProfileImgUrl"",
                ""website"": ""http://finnWebSite.com"",
                ""introduction"": ""핀입니다."",
                ""followerCount"": 1,
                ""followeeCount"": 1,
                ""postCount"": 2
            },
            ""userPosts"": [
                {
                    ""postIdx"": 2,
                    ""postImgUrl"": ""post2ImgUrl1""
                },
                {
                    ""postIdx"": 3,
                    ""postImgUrl"": ""post3ImgUrl1""
                }
            ]
        }
    }
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
}
