//
//  CollectionViewCell.swift
//  WebView2
//
//  Created by Anil Kumar on 27/12/21.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
  
  lazy var imageView: UIImageView! = {
    
    let image = UIImageView()
    image.translatesAutoresizingMaskIntoConstraints = false
    image.contentMode = .scaleToFill
    return image
    
  }()
    
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.contentView.backgroundColor = .white
    self.contentView.layer.cornerRadius = 10
    self.contentView.layer.masksToBounds = true
    self.backgroundColor = .white
    self.contentView.addSubview(self.imageView)
    
    NSLayoutConstraint.activate([
    
      self.imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
      self.imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
      self.imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
      self.imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),

    ])

  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
