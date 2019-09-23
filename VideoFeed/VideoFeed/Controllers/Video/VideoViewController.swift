//
//  ViewController.swift
//  VideoFeed
//
//  Created by Doyle Illusion on 9/5/19.
//  Copyright © 2019 Lixi Technologies. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class VideoViewController: UIViewController {
    
    private var reviews : [Review] = [
        Review(videoUrl: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4", placeholderUrl: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ElephantsDream.jpg", title: "Big Buck Bunny", body: "By Blender Foundation", user: User(avatarUrl: "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=80", name: "Hieu Hiep Nguyen", level: "Lv5"), tags: [
            Tag(name: "Hiepdeptrai"),
            Tag(name: "Hiepdethuong"),
            Tag(name: "Hieptaiba")
            ], likeCount: "123", commentCount: "123", starCount: "123"),
        Review(videoUrl: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4", placeholderUrl: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ElephantsDream.jpg", title: "Elephant Dream", body: "By Blender Foundation", user: User(avatarUrl: "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=80", name: "Hieu Hiep Nguyen", level: "Lv5"), tags: [
            Tag(name: "Hiepdeptrai"),
            Tag(name: "Hiepdethuong"),
            Tag(name: "Hieptaiba")
            ], likeCount: "123", commentCount: "123", starCount: "123"),
        Review(videoUrl: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4", placeholderUrl: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerBlazes.jpg", title: "For Bigger Blazes", body: "By Google", user: User(avatarUrl: "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=80", name: "Hieu Hiep Nguyen", level: "Lv5"), tags: [
            Tag(name: "Hiepdeptrai"),
            Tag(name: "Hiepdethuong"),
            Tag(name: "Hieptaiba")
            ], likeCount: "123", commentCount: "123", starCount: "123"),
        Review(videoUrl: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4", placeholderUrl: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerBlazes.jpg", title: "For Bigger Blazes", body: "By Google", user: User(avatarUrl: "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=80", name: "Hieu Hiep Nguyen", level: "Lv5"), tags: [
            Tag(name: "Hiepdeptrai"),
            Tag(name: "Hiepdethuong"),
            Tag(name: "Hieptaiba")
            ], likeCount: "123", commentCount: "123", starCount: "123"),
        Review(videoUrl: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4", placeholderUrl: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerBlazes.jpg", title: "For Bigger Blazes", body: "By Google", user: User(avatarUrl: "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=80", name: "Hieu Hiep Nguyen", level: "Lv5"), tags: [
            Tag(name: "Hiepdeptrai"),
            Tag(name: "Hiepdethuong"),
            Tag(name: "Hieptaiba")
            ], likeCount: "123", commentCount: "123", starCount: "123"),
        Review(videoUrl: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4", placeholderUrl: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerBlazes.jpg", title: "For Bigger Blazes", body: "By Google", user: User(avatarUrl: "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=80", name: "Hieu Hiep Nguyen", level: "Lv5"), tags: [
            Tag(name: "Hiepdeptrai"),
            Tag(name: "Hiepdethuong"),
            Tag(name: "Hieptaiba")
            ], likeCount: "123", commentCount: "123", starCount: "123"),
        Review(videoUrl: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4", placeholderUrl: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerBlazes.jpg", title: "For Bigger Blazes", body: "By Google", user: User(avatarUrl: "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=80", name: "Hieu Hiep Nguyen", level: "Lv5"), tags: [
            Tag(name: "Hiepdeptrai"),
            Tag(name: "Hiepdethuong"),
            Tag(name: "Hieptaiba")
            ], likeCount: "123", commentCount: "123", starCount: "123"),
        Review(videoUrl: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4", placeholderUrl: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerBlazes.jpg", title: "For Bigger Blazes", body: "By Google", user: User(avatarUrl: "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=80", name: "Hieu Hiep Nguyen", level: "Lv5"), tags: [
            Tag(name: "Hiepdeptrai"),
            Tag(name: "Hiepdethuong"),
            Tag(name: "Hieptaiba")
            ], likeCount: "123", commentCount: "123", starCount: "123"),
        Review(videoUrl: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4", placeholderUrl: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerBlazes.jpg", title: "For Bigger Blazes", body: "By Google", user: User(avatarUrl: "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=80", name: "Hieu Hiep Nguyen", level: "Lv5"), tags: [
            Tag(name: "Hiepdeptrai"),
            Tag(name: "Hiepdethuong"),
            Tag(name: "Hieptaiba")
            ], likeCount: "123", commentCount: "123", starCount: "123"),
        Review(videoUrl: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4", placeholderUrl: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerBlazes.jpg", title: "For Bigger Blazes", body: "By Google", user: User(avatarUrl: "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=80", name: "Hieu Hiep Nguyen", level: "Lv5"), tags: [
            Tag(name: "Hiepdeptrai"),
            Tag(name: "Hiepdethuong"),
            Tag(name: "Hieptaiba")
            ], likeCount: "123", commentCount: "123", starCount: "123")
    ]
    
    private let collectionNode : ASCollectionNode = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection  = .vertical
        let node = ASCollectionNode(collectionViewLayout: layout)
        node.backgroundColor = .black
        
        return node
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionNode()
        
        self.collectionNode.view.contentInsetAdjustmentBehavior = .never
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.collectionNode.frame = view.bounds
    }
    
    private func configureCollectionNode() {
        self.view.addSubnode(collectionNode)
        
        collectionNode.delegate = self
        collectionNode.dataSource = self
        
        self.collectionNode.view.isPagingEnabled = true
        
        (self.collectionNode.nodeForItem(at: IndexPath(item: 0, section: 0)) as? VideoCell)?.videoNode.videoNode.play()
    }
    
    private func checkVisibleNodes() {
        for node in collectionNode.visibleNodes {
            guard
                let videoCell = node as? VideoCell,
                let indexPath = collectionNode.indexPath(for: videoCell),
                let cellRect = collectionNode.view.layoutAttributesForItem(at: indexPath)
                else {
                    (node as? VideoCell)?.videoNode.videoNode.pause()
                    return
            }
            
            let superView = collectionNode.supernode
            
            let convertedRect = collectionNode.convert(cellRect.frame, to: superView)
            let intersect = collectionNode.frame.intersection(convertedRect)
            let visibleHeight = intersect.height
            
            if visibleHeight == UIScreen.main.bounds.size.height {
                videoCell.videoNode.videoNode.play()
            } else {
                videoCell.videoNode.videoNode.pause()
            }
        }
    }
    
    private func presentCommentsVC() {
        let controller = UINavigationController(rootViewController: CommentsViewController())
        controller.setNavigationBarHidden(true, animated: true)
        let transitionDelegate = SPStorkTransitioningDelegate()
        transitionDelegate.showCloseButton = false
        transitionDelegate.translateForDismiss = 100
        transitionDelegate.customHeight = UIScreen.main.bounds.size.height / 2
        transitionDelegate.showIndicator = false
        transitionDelegate.hapticMoments = [.willPresent, .willDismiss]
        controller.transitioningDelegate = transitionDelegate
        controller.modalPresentationStyle = .custom
        controller.modalPresentationCapturesStatusBarAppearance = true
        self.present(controller, animated: true, completion: nil)
    }
}

extension VideoViewController : ASCollectionDataSource {
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return reviews.count
    }

    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        guard reviews.count > indexPath.row else { return { ASCellNode() } }
        
        let review = reviews[indexPath.item]
        
        let cellNodeBlock = { () -> ASCellNode in
            let cellNode = VideoCell(review: review)
            
            cellNode.onTapTextField = { [weak self] in
                self?.presentCommentsVC()
            }
            
            cellNode.onTapCommentButton = { [weak self] in
                self?.presentCommentsVC()
            }
            
            return cellNode
        }
        
        return cellNodeBlock
    }
}

extension VideoViewController : ASCollectionDelegateFlowLayout, UICollectionViewDelegateFlowLayout {
    func collectionNode(_ collectionNode: ASCollectionNode, constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
        let size = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        return ASSizeRange(min: size, max: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        checkVisibleNodes()
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if decelerate {
            checkVisibleNodes()
        }
    }
}


