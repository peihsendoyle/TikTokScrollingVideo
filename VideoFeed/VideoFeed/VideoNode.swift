//
//  VideoNode.swift
//  VideoFeed
//
//  Created by Doyle Illusion on 9/5/19.
//  Copyright © 2019 Lixi Technologies. All rights reserved.
//

import AsyncDisplayKit

class VideoNode : ASDisplayNode {
    
    private var review: Review?
    
    public enum Direction {
        case forward
        case backward
    }
    
    private var isSeekInProgress = false
    private var chaseTime = CMTime.zero
    private var preferredFrameRate: Float = 23.98
    private var observer : Any?
    
    private let toggleButtonNode : ASButtonNode = {
        let node = ASButtonNode()
        node.imageNode.style.preferredSize = CGSize(width: 44, height: 44)
        node.setImage(UIImage(named: "play"), for: .normal)
        node.isHidden = true
        
        return node
    }()
    
    private let loadingNode : ASDisplayNode = {
        let node = ASDisplayNode(viewBlock: { () -> UIView in
            let view = UIActivityIndicatorView()
            view.hidesWhenStopped = true
            view.color = UIColor.white
            
            return view
        })
        
        return node
    }()
    
    let videoNode : ASVideoNode = {
        let node = ASVideoNode()
        node.shouldAutoplay = false
        node.gravity = AVLayerVideoGravity.resizeAspect.rawValue
        node.shouldAutorepeat = true
        node.muted = false
        node.shouldAutoplay = false
        
        return node
    }()
    
    private let sliderNode : ASDisplayNode = {
        let node = ASDisplayNode(viewBlock: { () -> UIView in
            let view = UISlider()
            
            return view
        })
        
        return node
    }()
    
    init(review : Review) {
        super.init()
        self.review = review
        
        self.configureLoadingNode()
        self.configureToggleButtonNode()
        self.configureSliderNode()
        self.configureVideoNode()
        
        automaticallyManagesSubnodes = true
    }
}

extension VideoNode {
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        sliderNode.style.height = ASDimension(unit: .points, value: 20)
        let insetSlider = ASInsetLayoutSpec(insets: UIEdgeInsets(top: CGFloat.infinity, left: 18, bottom: 0, right: 18), child: sliderNode)
        let sliderSpec = ASOverlayLayoutSpec(child: videoNode, overlay: insetSlider)
        
        loadingNode.style.preferredSize = CGSize(width: 64, height: 64)
        videoNode.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 49.0 - 16)
        let loadingSpec = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: .minimumXY, child: loadingNode)
        let loadingOverlaySpec = ASOverlayLayoutSpec(child: sliderSpec, overlay: loadingSpec)
        
        toggleButtonNode.style.preferredSize = CGSize(width: 44, height: 44)
        let toggleSpec = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: .minimumXY, child: toggleButtonNode)
        let toggleOverlaySpec = ASOverlayLayoutSpec(child: loadingOverlaySpec, overlay: toggleSpec)
        
        return toggleOverlaySpec
    }
}

extension VideoNode {
    private func configureLoadingNode() {
        
    }
    
    private func configureToggleButtonNode() {
        toggleButtonNode.addTarget(self, action: #selector(tapToggle), forControlEvents: .touchUpInside)
    }
    
    private func configureVideoNode() {
        videoNode.delegate = self
        
        if let placeholderUrlString = review?.placeholderUrl {
            videoNode.url = URL(string: placeholderUrlString)
        }
        
        guard let urlString = review?.videoUrl, let url = URL(string: urlString) else { return }
        let asset = AVAsset(url: url)
        
        DispatchQueue.main.async {
            self.videoNode.asset = asset
        }
    }
    
    private func configureSliderNode() {
        DispatchQueue.main.async {
            (self.sliderNode.view as? UISlider)?.maximumTrackTintColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1.0)
            (self.sliderNode.view as? UISlider)?.minimumTrackTintColor = UIColor(red: 255/255, green: 102/255, blue: 0/255, alpha: 1.0)
            (self.sliderNode.view as? UISlider)?.tintColor = UIColor(red: 255/255, green: 102/255, blue: 0/255, alpha: 1)
            (self.sliderNode.view as? UISlider)?.setThumbImage(UIImage(named: "thumb")?.withRenderingMode(.alwaysTemplate), for: .normal)
            (self.sliderNode.view as? UISlider)?.addTarget(self, action: #selector(self.sliderValueChanged), for: .valueChanged)
        }
    }
    
    @objc private func tapToggle() {
        debugPrint("tap play button!")
        videoNode.play()
    }
    
    @objc private func sliderValueChanged() {
        if videoNode.isPlaying() { videoNode.player?.pause() }
        
        guard var timeToSeek = videoNode.player?.currentItem?.duration.seconds else { return }
        timeToSeek = timeToSeek * Double((sliderNode.view as? UISlider)?.value ?? 0.0)
        seek(to: CMTimeMake(value: Int64(timeToSeek), timescale: 1))
    }
    
    public func seek(to time: CMTime) {
        seekSmoothlyToTime(newChaseTime: time)
    }
    
    public func stepByFrame(in direction: Direction) {
        let frameRate = preferredFrameRate
        
        let time = videoNode.player?.currentItem?.currentTime() ?? CMTime.zero
        let seconds = Double(1) / Double(frameRate)
        let timescale = Double(seconds) / Double(time.timescale) < 1 ? 600 : time.timescale
        let oneFrame = CMTime(seconds: seconds, preferredTimescale: timescale)
        let next = direction == .forward
            ? CMTimeAdd(time, oneFrame)
            : CMTimeSubtract(time, oneFrame)
        
        seekSmoothlyToTime(newChaseTime: next)
    }
    
    private func seekSmoothlyToTime(newChaseTime: CMTime) {
        if CMTimeCompare(newChaseTime, chaseTime) != 0 {
            chaseTime = newChaseTime
            
            if !isSeekInProgress {
                trySeekToChaseTime()
            }
        }
    }
    
    private func trySeekToChaseTime() {
        guard videoNode.player?.status == .readyToPlay else { return }
        actuallySeekToTime()
    }
    
    private func actuallySeekToTime() {
        isSeekInProgress = true
        let seekTimeInProgress = chaseTime
        
        videoNode.player?.seek(to: seekTimeInProgress, toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero) { [weak self] _ in
            guard let `self` = self else { return }
            
            if CMTimeCompare(seekTimeInProgress, self.chaseTime) == 0 {
                self.isSeekInProgress = false
            } else {
                self.trySeekToChaseTime()
            }
        }
    }
    
    private func addObserver() {
        guard let duration = videoNode.player?.currentItem?.duration.seconds else { return }
        self.observer = videoNode.player?.addPeriodicTimeObserver(forInterval: CMTime(seconds: 00.1, preferredTimescale: CMTimeScale(NSEC_PER_SEC)), queue: DispatchQueue.main, using: { [weak self] (time) in
            (self?.sliderNode.view as? UISlider)?.value = Float(time.seconds / duration)
        })
    }
}

extension VideoNode : ASVideoNodeDelegate {
    func didTap(_ videoNode: ASVideoNode) {
        if videoNode.isPlaying() {
            videoNode.pause()
        } else {
            videoNode.play()
        }
    }
    
    func videoNode(_ videoNode: ASVideoNode, willChange state: ASVideoNodePlayerState, to toState: ASVideoNodePlayerState) {
        switch toState {
        case .paused, .unknown, .playbackLikelyToKeepUpButNotPlaying:
            toggleButtonNode.isHidden = false
        case .readyToPlay:
            toggleButtonNode.isHidden = true
            addObserver()
        default:
            toggleButtonNode.isHidden = true
        }
    }
    
    func videoNodeDidStartInitialLoading(_ videoNode: ASVideoNode) {
        DispatchQueue.main.async {
            (self.loadingNode.view as? UIActivityIndicatorView)?.startAnimating()
        }
    }
    
    func videoNodeDidFinishInitialLoading(_ videoNode: ASVideoNode) {
        DispatchQueue.main.async {
            (self.loadingNode.view as? UIActivityIndicatorView)?.stopAnimating()
        }
    }
    
    func videoNode(_ videoNode: ASVideoNode, didStallAtTimeInterval timeInterval: TimeInterval) {
        DispatchQueue.main.async {
            (self.loadingNode.view as? UIActivityIndicatorView)?.startAnimating()
        }
    }
    
    func videoNodeDidRecover(fromStall videoNode: ASVideoNode) {
        DispatchQueue.main.async {
            (self.loadingNode.view as? UIActivityIndicatorView)?.stopAnimating()
        }
    }
}
