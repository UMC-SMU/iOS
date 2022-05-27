//
//  ReelsViewController.swift
//  Catstagram
//
//  Created by 문정호 on 2022/05/21.
//

import UIKit

class ReelsViewController: UIViewController{
    
    
    //MARK: - Properties
    @IBOutlet weak var collectionView: UICollectionView!
    private var nowPage = 0
    
    private let videoURLStrArr = ["dummyVideo", "dummyVideo2"]
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    //MARK: - Action
    
    //MARK: - Helpers
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.decelerationRate = .fast //스크롤이 내려가는 속도 조절하는 코드
        //collectionView.register(UINib(nibName: "ReelsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ReelsCollectionViewCell.identifier) //xib파일을 사용하여 UINib을 통해 생성
        collectionView.register(ReelsCell.self, forCellWithReuseIdentifier: ReelsCell.identifier) //코드를 통해 생성시키면 그냥
        
        startLoop()
    }
    
    private func startLoop() {
        let _ = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { _ in
            self.moveNextPage()
        }
    }
    
    private func moveNextPage() {
        let itemCount = collectionView.numberOfItems(inSection: 0)
        
        nowPage += 1
        if(nowPage >= itemCount){
            //마지막 페이지가 되면 다시 처음 페이지로 이동
            nowPage = 0
        }
        
        collectionView.scrollToItem(
            at: IndexPath(item: nowPage, section: 0),
            at: .centeredVertically, //수직으로 이동
            animated: true)
    }
}

//MARK: - UICollectionViewDelegate,UICollectionViewDataSource

extension ReelsViewController : UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReelsCell.identifier, for: indexPath)as? ReelsCell else { return UICollectionViewCell() }
        cell.setupURL(videoURLStrArr.randomElement()!)
        return cell
    }
    
    //메모리를 관리하기 위한 함수
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ReelsCell{
            cell.videoView?.cleanup()
        }
    }
}

//MARK: UICollectionViewFlowLayout
extension ReelsViewController : UICollectionViewDelegateFlowLayout{
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) ->CGSize {
        return CGSize(
            width: collectionView.frame.width,
            height: collectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        1
    }
}
