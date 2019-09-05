//
//  ActionNode.swift
//  VideoFeed
//
//  Created by Doyle Illusion on 9/5/19.
//  Copyright © 2019 Lixi Technologies. All rights reserved.
//

import AsyncDisplayKit

class ActionNode : ASDisplayNode {
    
    var review: Review?
    
    private let textFieldButtonNode : ASButtonNode = {
        let node = ASButtonNode()
        node.laysOutHorizontally = true
        node.contentHorizontalAlignment = .left
        node.contentVerticalAlignment = .center
        node.imageNode.style.preferredSize = CGSize(width: 25, height: 25)
        node.backgroundColor = UIColor.white
        node.cornerRadius = 16
        
        return node
    }()
    
    private let likeButtonNode : ASButtonNode = {
        let node = ASButtonNode()
        node.laysOutHorizontally = true
        node.contentHorizontalAlignment = .left
        node.contentVerticalAlignment = .top
        
        node.imageNode.style.preferredSize = CGSize(width: 28, height: 28)
        node.imageNode.contentMode = .scaleAspectFit
        
        return node
    }()
    
    private let starButtonNode : ASButtonNode = {
        let node = ASButtonNode()
        node.laysOutHorizontally = true
        node.contentHorizontalAlignment = .left
        node.contentVerticalAlignment = .top
        
        node.imageNode.style.preferredSize = CGSize(width: 28, height: 28)
        
        return node
    }()
    
    private let commentButtonNode : ASButtonNode = {
        let node = ASButtonNode()
        node.laysOutHorizontally = true
        node.contentHorizontalAlignment = .left
        node.contentVerticalAlignment = .top
        
        node.imageNode.style.preferredSize = CGSize(width: 28, height: 28)
        
        return node
    }()
    
    private let sliderNode : ASControlNode = {
        let node = ASControlNode(viewBlock: { () -> UIView in
            let view = UISlider()
            
            return view
        })
        
        return node
    }()
    
    init(review : Review) {
        super.init()
        self.review = review
        
        self.configureTextFieldButtonNode()
        self.configureLikeButtonNode()
        self.configureStarButtonNode()
        self.configureCommentButtonNode()
        
        automaticallyManagesSubnodes = true
    }
}

extension ActionNode {
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        textFieldButtonNode.style.flexGrow = 1
        textFieldButtonNode.style.height = ASDimension(unit: .points, value: 32)
        textFieldButtonNode.style.spacingAfter = 8
        likeButtonNode.style.flexBasis = ASDimension(unit: .fraction, value: 0.2)
        starButtonNode.style.flexBasis = ASDimension(unit: .fraction, value: 0.2)
        commentButtonNode.style.flexBasis = ASDimension(unit: .fraction, value: 0.2)
        let actionStack = ASStackLayoutSpec(direction: .horizontal, spacing: 0, justifyContent: .spaceBetween, alignItems: .center, children: [textFieldButtonNode, likeButtonNode, starButtonNode, commentButtonNode])
        actionStack.style.height = ASDimension(unit: .points, value: 49)
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16), child: actionStack)
    }
}

extension ActionNode {
    private func configureTextFieldButtonNode() {
        textFieldButtonNode.setImage(UIImage(named: "pencil"), for: .normal)
        textFieldButtonNode.setTitle("Bình luận", with: UIFont.systemFont(ofSize: 12, weight: .regular), with: UIColor(red: 208/255, green: 208/255, blue: 208/255, alpha: 1.0), for: .normal)
    }
    
    private func configureLikeButtonNode() {
        likeButtonNode.setImage(UIImage(named: "like")?.withRenderingMode(.alwaysTemplate), for: .normal)
        likeButtonNode.imageNode.imageModificationBlock = ASImageNodeTintColorModificationBlock(.white)
        likeButtonNode.setTitle(review?.likeCount ?? "0", with: UIFont.systemFont(ofSize: 12, weight: .regular), with: UIColor.white, for: .normal)
    }
    
    private func configureStarButtonNode() {
        starButtonNode.setImage(UIImage(named: "star")?.withRenderingMode(.alwaysTemplate), for: .normal)
        starButtonNode.imageNode.imageModificationBlock = ASImageNodeTintColorModificationBlock(.white)
        starButtonNode.setTitle(review?.starCount ?? "0", with: UIFont.systemFont(ofSize: 12, weight: .regular), with: UIColor.white, for: .normal)
    }
    
    private func configureCommentButtonNode() {
        commentButtonNode.setImage(UIImage(named: "comment")?.withRenderingMode(.alwaysTemplate), for: .normal)
        commentButtonNode.imageNode.imageModificationBlock = ASImageNodeTintColorModificationBlock(.white)
        commentButtonNode.setTitle(review?.commentCount ?? "0", with: UIFont.systemFont(ofSize: 12, weight: .regular), with: UIColor.white, for: .normal)
    }
}
