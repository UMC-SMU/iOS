//
//  ReelsViewController.swift
//  Catstagram
//
//  Created by 김유빈 on 2022/05/21.
//

import UIKit

class ReelsViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var collectionView: UICollectionView!
    private var nowPage = 0
    
    private let videoURLStrArr = ["dummyVideo01", "dummyVideo02"]
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }

    // MARK: - Actions
    
    
    // MARK: - Helpers
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.decelerationRate = .fast // 스크롤이 빨리 되도록 처리해줌
        collectionView.register(
            ReelsCell.self,
            forCellWithReuseIdentifier: ReelsCell.identifier)
        
        startLoop() // CollectionView 세팅이 완료된 후에 실행하도록
    }
    
    private func startLoop() {
        let _ = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { _ in
            self.moveNextPage()
        }
    }
    
    private func moveNextPage() {
        let itemCount = collectionView.numberOfItems(inSection: 0)
        
        nowPage += 1
        if (nowPage >= itemCount) {
            // 마지막페이지
            nowPage = 0
        }
        
        collectionView.scrollToItem(
            at: IndexPath(item: nowPage, section: 0),
            at: .centeredVertically, // 수직방향
            animated: true)
        // CollectionView가 2초마다 아래로 하나씩 내려감 & 마지막 페이지가 되면 첫번째 페이지로 이동
        
    }
    
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension ReelsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ReelsCell.identifier,
            for: indexPath) as? ReelsCell else { return UICollectionViewCell() }
        cell.setupURL(videoURLStrArr.randomElement()!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ReelsCell {
            cell.videoView?.cleanup() // cell이 보여주기가 끝났을 때 메소드 호출
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ReelsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: collectionView.frame.width,
            height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        1
    }
}
