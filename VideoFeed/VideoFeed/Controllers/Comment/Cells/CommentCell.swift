
//
//  CommentCell.swift
//  VideoFeed
//
//  Created by Doyle Illusion on 9/6/19.
//  Copyright © 2019 Lixi Technologies. All rights reserved.
//

import AsyncDisplayKit

class CommentCell : ASCellNode {
    
    private var comment : Comment?
    
    private var isSubcomment = false
    
    private let imageNode : ASNetworkImageNode = {
        let node = ASNetworkImageNode()
        node.defaultImage = UIImage(named: "avatar")
        node.contentMode = .scaleAspectFill
        node.cornerRadius = 32 / 2
        node.style.preferredSize = CGSize(width: 32, height: 32)
        
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
    
    private let dateNode : ASTextNode = {
        let node = ASTextNode()
        node.maximumNumberOfLines = 1
        node.truncationMode = .byTruncatingTail
        
        return node
    }()
    
    private let contentImageNode : ASNetworkImageNode = {
        let node = ASNetworkImageNode()
        node.contentMode = .scaleAspectFill
        node.cornerRadius = 4.0
        node.style.preferredSize = CGSize(width: 60, height: 60)
        
        return node
    }()
    
    private let contentNode : ASTextNode = {
        let node = ASTextNode()
        node.maximumNumberOfLines = 0
        node.style.flexShrink = 1
        
        return node
    }()
    
    private let likeButtonNode : ASButtonNode = {
        let node = ASButtonNode()
        node.laysOutHorizontally = true
        node.contentVerticalAlignment = .center
        node.contentHorizontalAlignment = .middle
        node.imageNode.style.preferredSize = CGSize(width: 20, height: 20)
        node.imageNode.contentMode = .scaleAspectFit
        node.setImage(UIImage(named: "like"), for: .normal)
        
        return node
    }()
    
    private let replyButtonNode : ASButtonNode = {
        let node = ASButtonNode()
        node.contentVerticalAlignment = ASVerticalAlignment.center
        node.contentHorizontalAlignment = ASHorizontalAlignment.left
        
        return node
    }()
    
    init(comment : Comment, isSubComment: Bool) {
        super.init()
        self.comment = comment
        self.isSubcomment = isSubComment
        
        configureImageNode()
        configureDateNode()
        configureNameNode()
        configureLevelNode()
        configureContentImageNode()
        configureContentNode()
        configureLikeButtonNode()
        configureReplyButtonNode()
        
        automaticallyManagesSubnodes = true
    }
}

extension CommentCell {
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let nameStack = ASStackLayoutSpec(direction: .horizontal, spacing: 7, justifyContent: .start, alignItems: .center, children: [nameNode, levelNode])
        let textStack = ASStackLayoutSpec(direction: .vertical, spacing: 3, justifyContent: .start, alignItems: .start, children: [nameStack, dateNode])
        
        let infoStack = ASStackLayoutSpec(direction: .horizontal, spacing: 10, justifyContent: .spaceBetween, alignItems: .center, children: [textStack, likeButtonNode])
        
        if isSubcomment {
            contentNode.style.width = ASDimension(unit: .points, value: UIScreen.main.bounds.size.width - 61 - 18 - 10 - 32)
        } else {
            contentNode.style.width = ASDimension(unit: .points, value: UIScreen.main.bounds.size.width - 36 - 10 - 32)
        }
        
        var commentStack : ASStackLayoutSpec!
        
        if comment?.imageUrl != nil {
            commentStack = ASStackLayoutSpec(direction: .vertical, spacing: 8, justifyContent: .start, alignItems: .stretch, children: [infoStack, contentImageNode, contentNode, replyButtonNode])
        } else {
            commentStack = ASStackLayoutSpec(direction: .vertical, spacing: 8, justifyContent: .start, alignItems: .stretch, children: [infoStack, contentNode, replyButtonNode])
        }

        let fullStack = ASStackLayoutSpec(direction: .horizontal, spacing: 10, justifyContent: .start, alignItems: .start, children: [imageNode, commentStack])
        
        if isSubcomment {
            return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 4, left: 61, bottom: 4, right: 18), child: fullStack)
        } else {
            return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 4, left: 18, bottom: 4, right: 18), child: fullStack)
        }
    }
}

extension CommentCell {
    private func configureImageNode() {
        guard let urlString = comment?.user?.avatarUrl, let url = URL(string: urlString) else { return }
        imageNode.url = url
    }
    
    private func configureDateNode() {
        guard let date = comment?.date else { return }
        dateNode.attributedText = NSAttributedString(string: date, attributes: [
            NSAttributedString.Key.foregroundColor : UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1.0),
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 10, weight: .regular)
            ])
    }
    
    private func configureNameNode() {
        guard let name = comment?.user?.name else { return }
        nameNode.attributedText = NSAttributedString(string: name, attributes: [
            NSAttributedString.Key.foregroundColor : UIColor.black,
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12, weight: .medium)
            ])
    }
    
    private func configureLevelNode() {
        guard let level = comment?.user?.level else { return }
        levelNode.setTitle(level, with: UIFont.systemFont(ofSize: 8, weight: .bold), with: .white, for: .normal)
    }
    
    private func configureLikeButtonNode() {
        likeButtonNode.setTitle(comment?.likeCount ?? "0", with: UIFont.systemFont(ofSize: 12, weight: .regular), with: UIColor(red: 74/255, green: 74/255, blue: 74/255, alpha: 1.0), for: .normal)
    }
    
    private func configureContentImageNode() {
        guard let imageUrlString = comment?.imageUrl, let url = URL(string: imageUrlString) else { return }
        contentImageNode.url = url
    }
    
    private func configureContentNode() {
        guard let content = comment?.content else { return }
        contentNode.attributedText = NSAttributedString(string: content, attributes: [
            NSAttributedString.Key.foregroundColor : UIColor.black,
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13, weight: .regular)
            ])
    }
    
    private func configureReplyButtonNode() {
        replyButtonNode.setTitle("Trả lời", with: UIFont.systemFont(ofSize: 12, weight: .bold), with: UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1.0), for: .normal)
    }
}
