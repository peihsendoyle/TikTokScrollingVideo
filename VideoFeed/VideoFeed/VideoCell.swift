//
//  VideoCell.swift
//  VideoFeed
//
//  Created by Doyle Illusion on 9/5/19.
//  Copyright © 2019 Lixi Technologies. All rights reserved.
//

import AsyncDisplayKit
import AVFoundation
import UIKit

class VideoCell : ASCellNode {
    
    private var review: Review?
    
    var videoNode : VideoNode!
    private var actionNode : ActionNode!
    private var infoNode : InfoNode!
    
    init(review: Review) {
        super.init()
        self.review = review
        
        configureVideoNode(review: review)
        configureActionNode(review: review)
        configureInfoNode(review: review)
        
        automaticallyManagesSubnodes = true
    }
}

extension VideoCell {
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let insets = UIEdgeInsets(top: CGFloat.infinity, left: 0, bottom: 32, right: 0)
        let insetsSpec = ASInsetLayoutSpec(insets: insets, child: infoNode)
        let overlaySpec = ASOverlayLayoutSpec(child: videoNode, overlay: insetsSpec)
        let fullStack = ASStackLayoutSpec(direction: .vertical, spacing: 0, justifyContent: .spaceBetween, alignItems: .stretch, children: [overlaySpec, actionNode])
        
        return fullStack
    }
}

extension VideoCell {
    private func configureVideoNode(review: Review) {
        videoNode = VideoNode(review: review)
    }
    
    private func configureActionNode(review: Review) {
        actionNode = ActionNode(review: review)
    }
    
    private func configureInfoNode(review: Review) {
        infoNode = InfoNode(review: review)
    }
}
