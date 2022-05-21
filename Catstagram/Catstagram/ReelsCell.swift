//
//  ReelsCell.swift
//  Catstagram
//
//  Created by 문정호 on 2022/05/21.
//

import Foundation
import SnapKit
import AVKit

class ReelsCell: UICollectionViewCell{
    static let identifier = "ReelsCell"
    
    //클래스 초기화 메소드
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupURL(_ urlStr: String){
        setupAttribute()
        setupLayout()
    }
    
    private func setupAttribute(){
        
    }
    
    private func setupLayout(){
        
    }
}
