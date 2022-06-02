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
    
    var videoView: VideoPlayerView?
    
    //릴스
    let cellTitleLabel = UILabel()
    
    //카메라
    let cameraImageView = UIImageView()
    
    //댓글
    let commentImageView = UIImageView()
    
    //좋아요
    let likeImageView = UIImageView()
    
    //공유하기
    let shareImageVIew = UIImageView()
    
    //클래스 초기화 메소드
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupURL(_ urlStr: String){
        self.videoView = VideoPlayerView(frame: .zero, urlStr: urlStr)
        setupAttribute()
        setupLayout()
    }
    
    private func setupAttribute(){
        cellTitleLabel.text = "릴스"
        cellTitleLabel.font = .boldSystemFont(ofSize: 25)
        cellTitleLabel.textAlignment = .left
        cellTitleLabel.textColor = .white
        
        [cameraImageView, shareImageVIew, likeImageView, commentImageView].forEach{
            $0.contentMode = .scaleAspectFit
            $0.tintColor = .white
        }//각 ImageView.contentMode = .scaleAspectFit를 자동화
        cameraImageView.image = UIImage(systemName: "camera")
        shareImageVIew.image = UIImage(systemName: "paperplane")
        commentImageView.image = UIImage(systemName: "message")
        likeImageView.image = UIImage(systemName: "suit.heart")
    }
    
    private func setupLayout(){
        guard let videoView = videoView else { return }
        contentView.addSubview(videoView)
        
        videoView.snp.makeConstraints{ make in
            make.edges.equalToSuperview() //contentView에 모든 엣지를 맞춘다.
        }
        
        [cellTitleLabel, cameraImageView,
         likeImageView,
         commentImageView,
         shareImageVIew]
            .forEach{contentView.addSubview($0)}
        
        cellTitleLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(20) //ContentView의 상단으로부터 20만큼 떨어진 위치
            make.leading.equalToSuperview().offset(20) //ContentView의 왼쪽으로부터 20만큼 떨어진 위치
        }
        
        cameraImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.width.height.equalTo(35)
        }
        
        shareImageVIew.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-50)
            make.trailing.trailing.equalToSuperview().offset(-20)
            make.width.height.equalTo(35)
        }
        
        let space = CGFloat(20)
        
        commentImageView.snp.makeConstraints{ make in
            make.bottom.equalTo(shareImageVIew.snp.top).offset(-space)
            make.centerX.equalTo(shareImageVIew)
            make.width.height.equalTo(35)
        }
        
        likeImageView.snp.makeConstraints{ make in
            make.bottom.equalTo(commentImageView.snp.top).offset(-space)
            make.centerX.equalTo(shareImageVIew)
            make.width.height.equalTo(35)
        }
    }
}
