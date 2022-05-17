//
//  UserFeedDataManager.swift
//  Catstagram
//
//  Created by 김유빈 on 2022/05/12.
//

import Alamofire

class UserFeedDataManager {
    // MARK: 유저 피드 조회 API
    func getUserFeed(_ viewController : ProfileViewController,
                     _ userID: Int = 2) { // 학습을 위한 서버 -> 2번 아이디를 통해서만 데이터를 넣고 받아 올 수 있도록 구성 => 실제 : 변수를 전달받음, 그것을 통해 url 구성
        // 통신
        AF.request("https://edu-api-ios-test.softsquared.com/users/\(userID)",
                   method: .get,
                   parameters: nil)
            .validate()
            .responseDecodable(of: UserFeedModel.self) { response in
                
            switch response.result {
            case .success(let result):
                viewController.successFeedAPI(result)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: 게시물 삭제 API
    func deleteUserFeed(_ viewController : ProfileViewController,
                     _ postIdx: Int) {
        // 통신
        AF.request("https://edu-api-ios-test.softsquared.com/posts/\(postIdx)/status",
                   method: .patch,
                   parameters: nil)
            .validate()
            .responseDecodable(of: DeleteUserFeed.self) { response in
                
            switch response.result {
            case .success(let result):
                // print("DEBUG: ", result) // 피드 삭제시 서버에서만 삭제되고 로컬에는 바로 반영되지 않는 상태
                viewController.successDeletePostAPI(result.isSuccess ?? false)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

