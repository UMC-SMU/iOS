//
//  ReelsViewController.swift
//  Catstagram
//
//  Created by 문정호 on 2022/05/21.
//

import UIKit
import SnapKit

class ReelsViewController: UIViewController{
    
    
    //MARK: - Properties
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let videoURLStrArr = ["dummyVideo", "dummyVideo2"]
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        
        // Do any additional setup after loading the view.
    }
    //MARK: - Action
    
    //MARK: - Helpers
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        //collectionView.register(UINib(nibName: "ReelsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ReelsCollectionViewCell.identifier) //xib파일을 사용하여 UINib을 통해 생성
        collectionView.register(ReelsCell.self, forCellWithReuseIdentifier: ReelsCell.identifier) //코드를 통해 생성시키면 그냥 
    }
}

//MARK: - UICollectionViewDelegate,UICollectionViewDataSource

extension ReelsViewController : UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReelsCell.identifier, for: indexPath)as? ReelsCell else { return UICollectionViewCell() }
        return cell
    }
    
}

//MARK: UICollectionViewFlowLayout
extension ReelsViewController : UICollectionViewDelegateFlowLayout{
    private func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:UICollectionViewFlowLayout, sizeForItemAt indexPath: IndexPath) ->CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        1
    }
}
