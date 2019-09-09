//
//  CommentsViewController.swift
//  VideoFeed
//
//  Created by Doyle Illusion on 9/6/19.
//  Copyright © 2019 Lixi Technologies. All rights reserved.
//

import AsyncDisplayKit
import SPFakeBar

class CommentsViewController : UIViewController {
    
    private var comments = [
        Comment(id: "1", user: User(avatarUrl: "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=80", name: "Hieu Hiep Nguyen", level: "Lv5"), content: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).", date: "25/08/2019", likeCount: "123", subcomments: [
                    Comment(id: "2", user: User(avatarUrl: "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=80", name: "Hieu Hiep Nguyen", level: "Lv5"), content: "Mẹ dở ẹc mà còn mang lên đây", date: "25/08/2019", likeCount: "123", subcomments: []),
                    Comment(id: "3", user: User(avatarUrl: "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=80", name: "Hieu Hiep Nguyen", level: "Lv5"), content: "Mẹ dở ẹc mà còn mang lên đây", date: "25/08/2019", likeCount: "123", subcomments: []),
                    Comment(id: "4", user: User(avatarUrl: "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=80", name: "Hieu Hiep Nguyen", level: "Lv5"), content: "Mẹ dở ẹc mà còn mang lên đây", date: "25/08/2019", likeCount: "123", subcomments: []),
                    Comment(id: "5", user: User(avatarUrl: "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=80", name: "Hieu Hiep Nguyen", level: "Lv5"), content: "Mẹ dở ẹc mà còn mang lên đây", date: "25/08/2019", likeCount: "123", subcomments: []),
                    Comment(id: "6", user: User(avatarUrl: "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=80", name: "Hieu Hiep Nguyen", level: "Lv5"), content: "Hay lam nha", date: "25/08/2019", likeCount: "123", subcomments: [])]),
            Comment(id: "7", user: User(avatarUrl: "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=80", name: "Hieu Hiep Nguyen", level: "Lv5"), content: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).", date: "25/08/2019", likeCount: "123", subcomments: []),
            Comment(id: "8", user: User(avatarUrl: "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=80", name: "Hieu Hiep Nguyen", level: "Lv5"), content: "Mẹ dở ẹc mà còn mang lên đây", date: "25/08/2019", likeCount: "123", subcomments: []),
            Comment(id: "9", user: User(avatarUrl: "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=80", name: "Hieu Hiep Nguyen", level: "Lv5"), content: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).", date: "25/08/2019", likeCount: "123", subcomments: []),
            Comment(id: "10", user: User(avatarUrl: "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=80", name: "Hieu Hiep Nguyen", level: "Lv5"), content: "Ahihihi.", date: "25/08/2019", likeCount: "123", subcomments: []),
            Comment(id: "11", user: User(avatarUrl: "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=80", name: "Hieu Hiep Nguyen", level: "Lv5"), content: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).", date: "25/08/2019", likeCount: "123", subcomments: []),
            Comment(id: "12", user: User(avatarUrl: "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=80", name: "Hieu Hiep Nguyen", level: "Lv5"), content: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).", date: "25/08/2019", likeCount: "123", subcomments: []),
            Comment(id: "13", user: User(avatarUrl: "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=80", name: "Hieu Hiep Nguyen", level: "Lv5"), content: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).", date: "25/08/2019", likeCount: "123", subcomments: [])
        ]
    
    var onDismiss : (() -> Void)?
    
    private let navBar = SPFakeBarView(style: .stork)
    private let commentActionNode = CommentActionNode(profile: User(avatarUrl: "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=80", name: "Hieu Hiep Nguyen", level: "Lv5"))
    
    private let fullHeight = UIScreen.main.bounds.size.height / 2
    private let fullWidth = UIScreen.main.bounds.size.width
    
    private let navBarHeight : CGFloat = 44
    
    private let commentActionHeight : CGFloat = 58
    private let commentActionWidth = UIScreen.main.bounds.size.width
    
    private let collectionNode : ASCollectionNode = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection  = .vertical
        let node = ASCollectionNode(collectionViewLayout: layout)
        node.backgroundColor = .black
        
        return node
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        collectionNode.frame = CGRect(x: 0, y: 0, width: fullWidth, height: fullHeight)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navBar.height = navBarHeight
        navBar.titleLabel.text = "Hiện tại có \(comments.count) bình luận"
        navBar.titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        navBar.rightButton.setImage(UIImage(named: "close"), for: .normal)
        navBar.rightButton.addTarget(self, action: #selector(self.dismissAction), for: .touchUpInside)
        
        configureCollectionNode()
        configureCommentActionNode()
        view.addSubview(self.navBar)
    }
    
    private func configureCollectionNode() {
        collectionNode.delegate = self
        collectionNode.dataSource = self
        collectionNode.backgroundColor = .white
        collectionNode.alwaysBounceVertical = true
        
        collectionNode.contentInset.top = navBarHeight
        collectionNode.view.scrollIndicatorInsets.top = navBarHeight
        
        collectionNode.contentInset.bottom = commentActionHeight
        collectionNode.view.scrollIndicatorInsets.bottom = commentActionHeight
        
        collectionNode.registerSupplementaryNode(ofKind: UICollectionView.elementKindSectionHeader)
        
        view.addSubnode(collectionNode)
    }
    
    private func configureCommentActionNode() {
        commentActionNode.frame = CGRect(x: 0, y: fullHeight - commentActionHeight, width: commentActionWidth, height: commentActionHeight)
        view.addSubnode(commentActionNode)
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag) {
            self.onDismiss?()
        }
    }
    
    @objc private func dismissAction() {
        self.dismiss(animated: true, completion: {
            self.onDismiss?()
        })
    }
}

extension CommentsViewController : ASCollectionDataSource {
    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        return comments.count + 1
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        } else {
            guard let subcomments = comments[section - 1].subcomments, subcomments.count > 0 else {
                return 0
            }
            return subcomments.count + 1
        }
        
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        let cellNodeBlock = { [weak self] () -> ASCellNode in
            if indexPath.item == 0 {
                guard let comment = self?.comments[indexPath.section - 1] else { return ASCellNode() }
                let cellNode = LoadingCell()
                cellNode.onTapAction = { [weak self] in
                    self?.loadMoreSubcomments(of: comment)
                }
                return cellNode
            } else {
                guard let comment = self?.comments[indexPath.section - 1].subcomments?[indexPath.item - 1] else { return ASCellNode() }
                let cellNode = CommentCell(comment: comment, isSubComment: true)
                return cellNode
            }
            
        }

        return cellNodeBlock
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> ASCellNode {
        if indexPath.section == 0 {
            let cellNode = LoadingCell()
            cellNode.onTapAction = { [weak self] in
                self?.loadMoreComments()
            }
            return cellNode
        } else {
            let comment = comments[indexPath.section - 1]
            let cellNode = CommentCell(comment: comment, isSubComment: false)
            return cellNode
        }
        
    }
}

extension CommentsViewController : ASCollectionDelegateFlowLayout {
    func collectionNode(_ collectionNode: ASCollectionNode, sizeRangeForHeaderInSection section: Int) -> ASSizeRange {
        return ASSizeRangeUnconstrained
    }
    func collectionNode(_ collectionNode: ASCollectionNode, constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
        return ASSizeRangeUnconstrained
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        SPStorkController.scrollViewDidScroll(scrollView)
    }
}

extension CommentsViewController {
    private func loadMoreComments() {
        let newComments = [
            Comment(id: "14", user: User(avatarUrl: "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=80", name: "Hieu Hiep Nguyen", level: "Lv5"), content: "Cai nay add them nha", date: "25/08/2019", likeCount: "123", subcomments: [
                Comment(id: "15", user: User(avatarUrl: "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=80", name: "Hieu Hiep Nguyen", level: "Lv5"), content: "Mẹ dở ẹc mà còn mang lên đây", date: "25/08/2019", likeCount: "123", subcomments: []),
                Comment(id: "16", user: User(avatarUrl: "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=80", name: "Hieu Hiep Nguyen", level: "Lv5"), content: "Mẹ dở ẹc mà còn mang lên đây", date: "25/08/2019", likeCount: "123", subcomments: []),
                Comment(id: "17", user: User(avatarUrl: "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=80", name: "Hieu Hiep Nguyen", level: "Lv5"), content: "Mẹ dở ẹc mà còn mang lên đây", date: "25/08/2019", likeCount: "123", subcomments: []),
                Comment(id: "18", user: User(avatarUrl: "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=80", name: "Hieu Hiep Nguyen", level: "Lv5"), content: "Mẹ dở ẹc mà còn mang lên đây", date: "25/08/2019", likeCount: "123", subcomments: []),
                Comment(id: "19", user: User(avatarUrl: "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=80", name: "Hieu Hiep Nguyen", level: "Lv5"), content: "Hay lam nha", date: "25/08/2019", likeCount: "123", subcomments: [])]
            )
        ]
        
        comments.insert(contentsOf: newComments, at: 0)
        collectionNode.reloadData()
    }
    
    private func loadMoreSubcomments(of comment: Comment) {
        guard let insertedIndex = comments.firstIndex(where: { $0.id == comment.id }) else { return }
        
        let newSubcomments = [
            Comment(id: "17", user: User(avatarUrl: "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=80", name: "Hieu Hiep Nguyen", level: "Lv5"), content: "Mẹ dở ẹc mà còn mang lên đây", date: "25/08/2019", likeCount: "123", subcomments: []),
            Comment(id: "8", user: User(avatarUrl: "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=80", name: "Hieu Hiep Nguyen", level: "Lv5"), content: "Mẹ dở ẹc mà còn mang lên đây", date: "25/08/2019", likeCount: "123", subcomments: []),
            Comment(id: "9", user: User(avatarUrl: "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=80", name: "Hieu Hiep Nguyen", level: "Lv5"), content: "Hay lam nha", date: "25/08/2019", likeCount: "123", subcomments: [])
        ]
        comments[insertedIndex].subcomments?.insert(contentsOf: newSubcomments, at: 0)
        collectionNode.reloadData()
    }
}
