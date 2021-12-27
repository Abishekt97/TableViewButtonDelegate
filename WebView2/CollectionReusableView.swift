//
//  CollectionReusableView.swift
//  WebView2
//
//  Created by Anil Kumar on 27/12/21.
//

import UIKit

class CollectionReusableView: UICollectionReusableView {
        
  lazy var label: UILabel! = {

    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .black
    label.font = .systemFont(ofSize: 17)
    label.textAlignment = .left
    label.baselineAdjustment = .alignCenters
    return label

  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    
    self.backgroundColor = .white
    self.addSubview(self.label)
    
    NSLayoutConstraint.activate([
    
      self.label.topAnchor.constraint(equalTo: self.topAnchor),
      self.label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
      self.label.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      self.label.bottomAnchor.constraint(equalTo: self.bottomAnchor),

    ])

  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
