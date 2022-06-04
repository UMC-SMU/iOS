//
//  VideoPlayerView.swift
//  Catstagram
//
//  Created by 김유빈 on 2022/05/21.
//

import UIKit
import AVKit

class VideoPlayerView: UIView {
    
    var playerLayer: AVPlayerLayer?
    var playerLooper: AVPlayerLooper?
    var queuePlayer: AVQueuePlayer?
    var urlStr: String
    
    init(frame: CGRect, urlStr: String) {
        self.urlStr = urlStr
        super.init(frame: frame)
        
        let videoFileURL = Bundle.main.url(forResource: urlStr, withExtension: "mp4")!
        let playItem = AVPlayerItem(url: videoFileURL)
        
        self.queuePlayer = AVQueuePlayer(playerItem: playItem)
        playerLayer = AVPlayerLayer()
        
        playerLayer!.player = queuePlayer
        playerLayer!.videoGravity = .resizeAspectFill
        
        self.layer.addSublayer(playerLayer!)
        
        playerLooper = AVPlayerLooper(player: queuePlayer!, templateItem: playItem)
        queuePlayer!.play()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func cleanup() {
        queuePlayer?.pause() // 멈춤
        queuePlayer?.removeAllItems() // 아이템 제거
        queuePlayer = nil // 객체 제거
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer!.frame = bounds // layout이 업데이트 될 때마다 player의 frame을 현재 view의 frame(bounds)과 맞춰주도록 설정
    }
}
