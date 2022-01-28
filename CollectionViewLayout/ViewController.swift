//
//  ViewController.swift
//  CollectionViewLayout
//
//  Created by Anil Kumar on 03/01/22.
//

import UIKit

class ViewController: UIViewController {
  
  static let cellIdentutyfier = "cellReUseIdentutyfier"
  
  lazy var collectionView: UICollectionView! = {
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.backgroundColor = .clear
    collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: String(describing: CollectionViewCell.self))
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ViewController.cellIdentutyfier)
    collectionView.delegate = self
    collectionView.dataSource = self
    return collectionView
  }()
  
  lazy var layout: UICollectionViewFlowLayout! = {
    
    let layouts = AlignedCollectionViewFlowLayout()
    layouts.sectionInset = .init(top: 10, left: 10, bottom: 10, right: 10)
    layouts.horizontalAlignment = .right
    return layouts
    
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = .white
    self.navigationController?.isNavigationBarHidden = true
    
    //
    self.view.addSubview(self.collectionView)
    
    NSLayoutConstraint.activate([
      
      self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
      self.collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
      self.collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
      self.collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
      
    ])
  }
  
}

extension ViewController: UICollectionViewDelegate{
  
  
  
}

extension ViewController: UICollectionViewDataSource{
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return Images.carImages.count
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return Images.carImages[section].count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
//    if indexPath.row % 2 == 1{
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CollectionViewCell.self), for: indexPath) as! CollectionViewCell
      cell.imageView.image = Images.carImages[indexPath.section][indexPath.row]
      return cell
//    }else{
//
//      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ViewController.cellIdentutyfier, for: indexPath)
//      var content = cell.backgroundConfiguration
//      content?.image = Images.carImages[indexPath.section][indexPath.row]
//      content?.backgroundColor = .yellow
//      return cell
//    }
  }
  
}
