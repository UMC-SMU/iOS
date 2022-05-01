//
//  PostCollectionViewCell.swift
//  Catstagram
//
//  Created by 김유빈 on 2022/04/30.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {
    static let identifier = "PostCollectionViewCell"

    @IBOutlet weak var postImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func setupData() {
        // 이미지뷰의 이미지를 업로드한다.
    }

}
