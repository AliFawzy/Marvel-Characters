//
//  StretchyHeader.swift
//  Marvel
//
//  Created by Mac on 11/11/2022.
//  Copyright © 2022 Aly Fawzy. All rights reserved.
//

import Foundation
import UIKit


final class StretchyImage_TableViewheader: UIView{
    public let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.roundCorners([.bottomLeft, .bottomRight], radius: 20)
        return imageView
    }()
    
    private var imageViewHight = NSLayoutConstraint()
    private var imageViewBottom = NSLayoutConstraint()
    private var containerView = UIView()
    private var containerViewHight = NSLayoutConstraint()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        creatViews()
        setViewConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // create subviews
    private func creatViews() {
        addSubview(containerView)
        containerView.addSubview(imageView)
    }
    
    func setViewConstraints() {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalTo: containerView.widthAnchor),
            centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            heightAnchor.constraint(equalTo: containerView.heightAnchor)
        ])
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.widthAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        containerViewHight = containerView.heightAnchor.constraint(equalTo: self.heightAnchor)
        containerViewHight.isActive = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageViewBottom = imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        imageViewBottom.isActive = true
        imageViewHight = imageView.heightAnchor.constraint(equalTo: containerView.heightAnchor)
        imageViewHight.isActive = true
    }
    
    //  notify view of scroll change from container
    public func scrollViewDidScroll(scrollView: UIScrollView){
        containerViewHight.constant = scrollView.contentInset.top
        let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top)
        containerView.clipsToBounds = offsetY <= 0
        imageViewBottom.constant = offsetY >= 0 ? 0 : -offsetY/2
        imageViewHight.constant = max(offsetY+scrollView.contentInset.top, scrollView.contentInset.top)
    }
}
