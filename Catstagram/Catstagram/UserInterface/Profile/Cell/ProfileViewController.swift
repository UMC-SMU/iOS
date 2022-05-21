//
//  ProfileViewController.swift
//  Catstagram
//
//  Created by 문정호 on 2022/04/30
//

import UIKit
import SwiftUI

class ProfileViewController: UIViewController, UIGestureRecognizerDelegate {
    // MARK: - Properties
    @IBOutlet weak var profileCollectionView: UICollectionView!
    
    var userPosts: [GetUserPosts]?{ //UI를 먼저 그린 후 데이터를 받아오고 있기 때문에 relaoadData()를 해주어야 함
        didSet{ self.profileCollectionView.reloadData() }
    }
    
    var deletedIndex :Int?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupData()
        
    }
    
    // MARK: - Actions
    @objc func didLongPressCell(gestureRecognizer: UILongPressGestureRecognizer){
        if gestureRecognizer.state != .began { return } //방어코드 : 오작동을 막기 위함. 오래 누르기를 시작한 상태가 아니라면 그저 리턴
        let position = gestureRecognizer.location(in: profileCollectionView)
        
        if let indexPath = profileCollectionView?.indexPathForItem(at: position){
            print("DEBUG : ", indexPath.item)
            
            guard let userPosts = self.userPosts else { return }
            let cellData = userPosts[indexPath.item]
            self.deletedIndex = indexPath.item
            if let postIdx = cellData.postIdx{
                //삭제 API를 호출
                UserFeedDataManager().DeleteUserFeed(self, postIdx)
            }
            
        }
        
    }
    
    
    // MARK: - Helpers
    private func setupCollectionView() {
        // delegate 연결
        profileCollectionView.delegate = self
        profileCollectionView.dataSource = self
        
        // cell 등록
        profileCollectionView.register(
            UINib(nibName: "ProfileCollectionViewCell",
                  bundle: nil),
            forCellWithReuseIdentifier: ProfileCollectionViewCell.identifier)
        
        profileCollectionView.register(
            UINib(nibName: "PostCollectionViewCell",
                  bundle: nil),
            forCellWithReuseIdentifier:  PostCollectionViewCell.identifier)
        
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(didLongPressCell(gestureRecognizer:)))
        gesture.minimumPressDuration = 0.66
        gesture.delegate = self
        gesture.delaysTouchesBegan = true
        profileCollectionView.addGestureRecognizer(gesture)
    }
    
    private func setupData(){
        UserFeedDataManager().getUserFeed(self)
    }
}


// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    // 섹션의 갯수
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    // cell의 갯수
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default: // 1 (0부터 시작하기 때문에)
            return userPosts?.count ?? 0
        }
    }
    
    // cell 생성
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let section = indexPath.section
        switch section {
        case 0: // Profile
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProfileCollectionViewCell.identifier,
                for: indexPath) as? ProfileCollectionViewCell else {
                    fatalError("셀 타입 캐스팅 실패...")
                }
            
            return cell
        default: // Post
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PostCollectionViewCell.identifier,
                for: indexPath) as? PostCollectionViewCell else {
                    fatalError("셀 타입 캐스팅 실패...")
                }
            let itemIndex = indexPath.item
            if let cellData = self.userPosts { // 만약 userposts 값이 있어서 할당이 가능하다면
                //데이터가 있는 경우, cell 데이터를 전달
                cell.setupData(cellData[itemIndex].postImgUrl)// <-- 데이터 전달
            }
             
            
            return cell
        }
    }
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let section = indexPath.section
        switch section {
        case 0: // Profile
            return CGSize(
                width: collectionView.frame.width,
                height: CGFloat(159))
        default: // Post
            let side = CGFloat((collectionView.frame.width / 3) - (4/3))
            return CGSize(
                width: side,
                height: side)
        }
    }
    
    // item간 Spacing(열간 간격)
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch section {
        case 0:
            return CGFloat(0)
        default:
            return CGFloat(1)
        }
    }
    
    // line간 Spacing(행간 간격)
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch section {
        case 0:
            return CGFloat(0)
        default:
            return CGFloat(1)
        }
    }
}


// MARK: -API통신 메소드

extension ProfileViewController{
    func successFeedAPI(_ result: UserFeedModel){
        self.userPosts = result.result?.getuserPosts
    }
    
    func successDeletePostAPI(_ isSuccess: Bool){
        guard isSuccess else{ return }
        
        if let deletedIndex = self.deletedIndex{
            self.userPosts?.remove(at: deletedIndex)
        }
    }
}
