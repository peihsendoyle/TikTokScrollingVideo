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
    
    private var observer : Any?
    private var mRestoreAfterScrubbingRate : Float = 0
    private var isSeeking = false
    
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
            
            (self.sliderNode.view as? UISlider)?.addTarget(self, action: #selector(self.endScrubbing), for: .touchCancel)
            (self.sliderNode.view as? UISlider)?.addTarget(self, action: #selector(self.beginScrubbing), for: .touchDown)
            (self.sliderNode.view as? UISlider)?.addTarget(self, action: #selector(self.scrub), for: .touchDragInside)
            (self.sliderNode.view as? UISlider)?.addTarget(self, action: #selector(self.endScrubbing), for: .touchUpInside)
            (self.sliderNode.view as? UISlider)?.addTarget(self, action: #selector(self.endScrubbing), for: .touchUpOutside)
            (self.sliderNode.view as? UISlider)?.addTarget(self, action: #selector(self.scrub), for: .valueChanged)
        }
    }
    
    @objc private func tapToggle() {
        debugPrint("tap play button!")
        videoNode.play()
    }
    
    private func removePlayerTimeObserver() {
        observer = nil
    }
    
    func initScrubberTimer() {
        var interval: Double = 0.1
        guard let playerDuration = videoNode.currentItem?.duration else { return }
        guard let width = (sliderNode.view as? UISlider)?.bounds.width else { return }
        if CMTIME_IS_INVALID(playerDuration) { return }
        
        let duration: Double = CMTimeGetSeconds(playerDuration)
        if duration.isFinite { interval = 0.5 * duration / Double(width) }
        /* Update the scrubber during normal playback. */
        weak var weakSelf = self
        observer = videoNode.player?.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(interval, preferredTimescale: Int32(NSEC_PER_SEC)), queue: nil, using: {(time: CMTime) -> Void in
            weakSelf?.syncScrubber()
        }) as AnyObject?
    }
    
    func syncScrubber() {
        guard let playerDuration = videoNode.currentItem?.duration else { return }
        
        if CMTIME_IS_INVALID(playerDuration) {
            (sliderNode.view as? UISlider)?.minimumValue = 0.0
            return
        }
        
        let duration: Double = CMTimeGetSeconds(playerDuration)
        if duration.isFinite {
            guard let minValue = (sliderNode.view as? UISlider)?.minimumValue else { return }
            guard let maxValue = (sliderNode.view as? UISlider)?.maximumValue else { return }
            let time: Double = CMTimeGetSeconds(videoNode.player?.currentTime() ?? CMTime(seconds: 0, preferredTimescale: CMTimeScale(1)))
            let up = (maxValue - minValue) * Float(time)
            let down = Float(duration) + minValue
            (sliderNode.view as? UISlider)?.value = up / down
        }
    }
    
    @objc private func beginScrubbing() {
        mRestoreAfterScrubbingRate = videoNode.player?.rate ?? 0
        videoNode.player?.rate = 0.0
        self.removePlayerTimeObserver()
    }
    
    @objc private func scrub(_ sender: AnyObject) {
        if (sender is UISlider) && !isSeeking {
            isSeeking = true
            let slider = sender
            guard let playerDuration = videoNode.currentItem?.duration else { return }
            
            if CMTIME_IS_INVALID(playerDuration) { return }
            
            let duration: Double = CMTimeGetSeconds(playerDuration)
            if duration.isFinite {
                let minValue: Float = slider.minimumValue
                let maxValue: Float = slider.maximumValue
                let value: Float = slider.value
                let time = (duration * Double((value - minValue) / (maxValue - minValue)))
                weak var weakSelf = self
                videoNode.player?.seek(to: CMTimeMakeWithSeconds(time, preferredTimescale: Int32(NSEC_PER_SEC)), completionHandler: {(finished: Bool) -> Void in
                    DispatchQueue.main.async(execute: {() -> Void in
                        weakSelf?.isSeeking = false
                    })
                })
            }
        }
    }
    
    @objc private func endScrubbing() {
        guard observer == nil else { return }
        
        if mRestoreAfterScrubbingRate != 0.0 {
            videoNode.player?.rate = mRestoreAfterScrubbingRate
            mRestoreAfterScrubbingRate = 0.0
            videoNode.play()
        }
        
        guard let playerDuration = videoNode.currentItem?.duration else { return }
        if CMTIME_IS_INVALID(playerDuration) { return }
        
        let duration: Double = CMTimeGetSeconds(playerDuration)
        if duration.isFinite {
            let width: CGFloat = sliderNode.bounds.width
            let tolerance: Double = 0.5 * duration / Double(width)
            
            weak var weakSelf = self
            observer = videoNode.player?.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(tolerance, preferredTimescale: Int32(NSEC_PER_SEC)), queue: nil, using: {(time: CMTime) -> Void in
                weakSelf?.syncScrubber()
            }) as AnyObject?
        }
    }
    
    private func isScrubbing() -> Bool {
        return mRestoreAfterScrubbingRate != 0.0
    }
    
    func enableScrubber() {
        (videoNode.view as? UISlider)?.isEnabled = true
    }
    
    func disableScrubber() {
        (videoNode.view as? UISlider)?.isEnabled = false
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
            initScrubberTimer()
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
