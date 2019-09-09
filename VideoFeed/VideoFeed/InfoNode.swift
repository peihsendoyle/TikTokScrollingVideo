//
//  InfoNode.swift
//  VideoFeed
//
//  Created by Doyle Illusion on 9/5/19.
//  Copyright © 2019 Lixi Technologies. All rights reserved.
//

import AsyncDisplayKit

class InfoNode : ASDisplayNode {
    
    private var review: Review?
    
    private let imageNode : ASNetworkImageNode = {
        let node = ASNetworkImageNode()
        node.defaultImage = UIImage(named: "avatar")
        node.contentMode = .scaleAspectFill
        node.cornerRadius = 44 / 2
        
        return node
    }()
    
    private let nameNode : ASTextNode = {
        let node = ASTextNode()
        node.truncationMode = .byTruncatingTail
        node.maximumNumberOfLines = 1
        
        return node
    }()
    
    private let levelNode : ASButtonNode = {
        let node = ASButtonNode()
        node.cornerRadius = 6
        node.contentEdgeInsets = UIEdgeInsets(top: 3, left: 6, bottom: 3, right: 6)
        node.backgroundColor = UIColor(red: 255/255, green: 195/255, blue: 23/255, alpha: 1)
        
        return node
    }()
    
    private let titleNode : ASTextNode = {
        let node = ASTextNode()
        node.maximumNumberOfLines = 1
        node.truncationMode = .byTruncatingTail
        
        return node
    }()
    
    private let bodyNode : ASTextNode = {
        let node = ASTextNode()
        node.maximumNumberOfLines = 2
        node.truncationMode = .byTruncatingTail
        
        return node
    }()
    
    private var tagNodes = [ASButtonNode]()
    
    init(review : Review) {
        super.init()
        self.review = review
        
        configureImageNode()
        configureNameNode()
        configureLevelNode()
        configureTitleNode()
        configureBodyNode()
        configureTagNodes()
        
        automaticallyManagesSubnodes = true
    }
}

extension InfoNode {
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let flexSpec = ASStackLayoutSpec(direction: .horizontal, spacing: 6.0, justifyContent: .start, alignItems: .center, children: tagNodes)
        flexSpec.flexWrap = .wrap
        flexSpec.lineSpacing = 6.0
        
        imageNode.style.preferredSize = CGSize(width: 44, height: 44)
        let infoSpec = ASStackLayoutSpec(direction: .horizontal, spacing: 10, justifyContent: .start, alignItems: .center, children: [imageNode, nameNode, levelNode])
        
        let fullStack = ASStackLayoutSpec(direction: .vertical, spacing: 8, justifyContent: .end, alignItems: .stretch, children: [infoSpec, titleNode, bodyNode, flexSpec])
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 4, left: 18, bottom: 10, right: 18), child: fullStack)
    }
}

extension InfoNode {
    private func configureImageNode() {
        guard let urlString = review?.user?.avatarUrl, let url = URL(string: urlString) else { return }
        imageNode.url = url
    }
    
    private func configureNameNode() {
        guard let name = review?.user?.name else { return }
        nameNode.attributedText = NSAttributedString(string: name, attributes: [
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: .medium)
            ])
    }
    
    private func configureLevelNode() {
        guard let level = review?.user?.level else { return }
        levelNode.setTitle(level, with: UIFont.systemFont(ofSize: 8, weight: .bold), with: .white, for: .normal)
    }
    
    private func configureTitleNode() {
        guard let title = review?.title else { return }
        titleNode.attributedText = NSAttributedString(string: title, attributes: [
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: .medium)
            ])
    }
    
    private func configureBodyNode() {
        guard let body = review?.body else { return }
        bodyNode.attributedText = NSAttributedString(string: body, attributes: [
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: .regular)
            ])
    }
    
    private func configureTagNodes() {
        guard let tags = review?.tags else { return }
        
        tags.forEach { (tag) in
            let buttonNode = ASButtonNode()
            buttonNode.backgroundColor = UIColor(red: 255/255, green: 222/255, blue: 209/255, alpha: 1)
            buttonNode.cornerRadius = 10
            buttonNode.laysOutHorizontally = true
            buttonNode.contentHorizontalAlignment = .middle
            buttonNode.contentVerticalAlignment = .center
            buttonNode.style.flexShrink = 1
            buttonNode.imageNode.style.preferredSize = CGSize(width: 12, height: 12)
            buttonNode.contentEdgeInsets = UIEdgeInsets(top: 3, left: 5, bottom: 3, right: 5)
            buttonNode.setTitle(tag.name, with: UIFont.systemFont(ofSize: 12, weight: .regular), with: UIColor(red: 255/255, green: 102/255, blue: 0/255, alpha: 1), for: .normal)
            buttonNode.setImage(UIImage(named: "tag"), for: .normal)
            
            tagNodes.append(buttonNode)
        }
    }
}
