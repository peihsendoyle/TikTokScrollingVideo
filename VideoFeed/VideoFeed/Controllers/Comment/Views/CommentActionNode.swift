//
//  CommentActionCell.swift
//  VideoFeed
//
//  Created by MAC on 9/9/19.
//  Copyright © 2019 Lixi Technologies. All rights reserved.
//

import AsyncDisplayKit

class CommentActionNode : ASDisplayNode {
    
    private var user : User?
    
    private let imageNode : ASNetworkImageNode = {
        let node = ASNetworkImageNode()
        node.contentMode = .scaleAspectFit
        node.style.preferredSize = CGSize(width: 32, height: 32)
        node.cornerRadius = 32 / 2
        
        return node
    }()
    
    private let textFieldButtonNode : ASButtonNode = {
        let node = ASButtonNode()
        node.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1.0)
        node.setTitle("Bình luận đi bạn ei", with: UIFont.systemFont(ofSize: 12, weight: .regular), with: UIColor(red: 208/255, green: 208/255, blue: 208/255, alpha: 1.0), for: .normal)
        node.style.height = ASDimension(unit: .points, value: 32)
        node.cornerRadius = 32 / 2
        node.style.flexGrow = 1
        node.contentHorizontalAlignment = .left
        node.contentEdgeInsets.left = 10
        
        return node
    }()
    
    private let sendButtonNode : ASButtonNode = {
        let node = ASButtonNode()
        node.setImage(UIImage(named: "send"), for: .normal)
        node.style.preferredSize = CGSize(width: 32, height: 32)
        node.imageNode.style.preferredSize = CGSize(width: 9.8, height: 9.8)
        node.cornerRadius = 32 / 2
        node.layer.masksToBounds = true
        node.layer.borderColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 0.7).cgColor
        node.layer.borderWidth = 0.8
        
        return node
    }()
    
    init(profile: User) {
        super.init()
        self.user = profile
        
        backgroundColor = .white
        configureImageNode()
        
        automaticallyManagesSubnodes = true
    }
}

extension CommentActionNode {
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let horizontalStack = ASStackLayoutSpec(direction: .horizontal, spacing: 15, justifyContent: .spaceBetween, alignItems: .center, children: [imageNode, textFieldButtonNode, sendButtonNode])
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 8, left: 18, bottom: 18, right: 18), child: horizontalStack)
    }
}

extension CommentActionNode {
    private func configureImageNode() {
        guard let urlString = user?.avatarUrl, let url = URL(string: urlString) else { return }
        imageNode.url = url
    }
}
