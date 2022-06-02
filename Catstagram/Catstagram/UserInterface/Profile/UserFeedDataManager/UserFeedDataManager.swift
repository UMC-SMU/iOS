//
//  UserFeedDataManager.swift
//  Catstagram
//
//  Created by 문정호 on 2022/05/19.
//

import Alamofire

class UserFeedDataManager {
    //MARK: 유저 피드 조회 API
    //학습을 위한 서버라서 2번 아이디에만 데이터를 넣어놓음 -> 그래서 userID를 아예 2번으로 고정
    func getUserFeed(_ viewController : ProfileViewController, _ userID : Int = 2){
        //통신
        AF.request("https://edu-api-ios-test.softsquared.com/users/\(userID)", method: .get, parameters: nil ).validate().responseDecodable(of: UserFeedModel.self){ response in
            switch response.result {
            case .success(let result):
                viewController.successFeedAPI(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: 게시물 삭제 API
    func DeleteUserFeed(_ viewController : ProfileViewController, _ postIdx : Int){
        //통신
        
        AF.request("https://edu-api-ios-test.softsquared.com/posts/\(postIdx)/status", method: .patch, parameters: nil ).validate().responseDecodable(of: UserFeedModel.self){response in
            switch response.result {
            case .success(let result):
                viewController.successDeletePostAPI(result.isSuccess ?? false)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
