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
    
    private let videoNode : ASVideoNode = {
        let node = ASVideoNode()
        node.shouldAutoplay = false
        node.gravity = AVLayerVideoGravity.resizeAspect.rawValue
        node.shouldAutorepeat = false
        node.muted = false
        node.shouldAutoplay = true
        
        return node
    }()
    
    init(review : Review) {
        super.init()
        self.review = review
        
        self.configureLoadingNode()
        self.configureToggleButtonNode()
        self.configureVideoNode()
        
        automaticallyManagesSubnodes = true
    }
}

extension VideoNode {
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        loadingNode.style.preferredSize = CGSize(width: 64, height: 64)
        videoNode.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 49.0 - 16)
        let loadingSpec = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: .minimumXY, child: loadingNode)
        let loadingOverlaySpec = ASOverlayLayoutSpec(child: videoNode, overlay: loadingSpec)
        
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
    
    @objc private func tapToggle() {
        debugPrint("tap play button!")
        videoNode.play()
    }
}

extension VideoNode : ASVideoNodeDelegate {
    func didTap(_ videoNode: ASVideoNode) {
        videoNode.pause()
    }
    
    func videoNode(_ videoNode: ASVideoNode, willChange state: ASVideoNodePlayerState, to toState: ASVideoNodePlayerState) {
        switch toState {
        case .paused, .unknown, .playbackLikelyToKeepUpButNotPlaying:
            toggleButtonNode.isHidden = false
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
