//
//  LoadingCell.swift
//  VideoFeed
//
//  Created by MAC on 9/9/19.
//  Copyright © 2019 Lixi Technologies. All rights reserved.
//

import AsyncDisplayKit

class LoadingCell : ASCellNode {
    
    var onTapAction : (() -> Void)?
    
    private let indicatorNode : ASDisplayNode = {
        let node = ASDisplayNode(viewBlock: { () -> UIView in
            let view = UIActivityIndicatorView()
            view.color = UIColor.gray
            
            return view
        })
        
        node.isHidden = true
        
        return node
    }()
    
    private let titleNode : ASTextNode = {
        let node = ASTextNode()
        node.truncationMode = .byTruncatingTail
        node.maximumNumberOfLines = 1
        node.attributedText = NSAttributedString(string: "Xem những bình luận cũ hơn...", attributes: [
            NSAttributedString.Key.foregroundColor : UIColor.darkText,
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12, weight: .medium)
            ])
        
        return node
    }()
    
    override init() {
        super.init()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        
        DispatchQueue.main.async {
            self.view.addGestureRecognizer(tap)
        }
        
        automaticallyManagesSubnodes = true
    }
}

extension LoadingCell {
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        indicatorNode.style.preferredSize = CGSize(width: 44, height: 44)
        let loadingSpec = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: .minimumXY, child: indicatorNode)
        let textSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 8, left: 18, bottom: 8, right: 18), child: titleNode)
        let overlaySpec = ASOverlayLayoutSpec(child: textSpec, overlay: loadingSpec)
        
        return overlaySpec
    }
}

extension LoadingCell {
    @objc private func tapAction() {
        indicatorNode.isHidden = false
        titleNode.isHidden = true
        
        onTapAction?()
    }
}
