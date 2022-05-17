//
//  StoryTableViewCell.swift
//  Catstagram
//
//  Created by 김유빈 on 2022/04/14.
//

import UIKit

class StoryTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    
    func setCollectionViewDataSourceDelegate(dataSourceDelegate : UICollectionViewDelegate & UICollectionViewDataSource, forRow row: Int)
        {
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = row
        let storyNib = UINib(nibName: "StoryCollectionViewCell", bundle: nil)
        collectionView.register(storyNib, forCellWithReuseIdentifier: "StoryCollectionViewCell")
            
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        flowLayout.minimumLineSpacing = 12
            
        collectionView.collectionViewLayout = flowLayout
            
        collectionView.reloadData() // 등록이 되었을 때 다시 한 번 더 collectionView를 리로딩, 재부팅 해보라는 뜻
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
