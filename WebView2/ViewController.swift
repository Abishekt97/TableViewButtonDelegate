//
//  ViewController.swift
//  WebView2
//
//  Created by Anil Kumar on 27/12/21.
//

import UIKit

class ViewController: UIViewController {
  
  var dataSource: UICollectionViewDiffableDataSource<Int, UIImage>! = nil

  lazy var collectionView: UICollectionView! = {
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.backgroundColor = .clear
    collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: String(describing: CollectionViewCell.self))
    collectionView.delegate = self
    return collectionView
  }()
  
  lazy var layout: UICollectionViewLayout = {
    
    let layOut = UICollectionViewCompositionalLayout { section, environment in
      
      var group = NSCollectionLayoutGroup(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(2), heightDimension: .fractionalHeight(0.35)))
      if Images.carImages[section].count > 1 {
        let leadingItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let group1 = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)), subitem: leadingItem, count: 1)

        group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalHeight(0.3), heightDimension: .fractionalHeight(0.3)), subitem: group1, count: 1)
      }else{
        let leadingItem1 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        leadingItem1.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.4)), subitems: [leadingItem1])
      }
        
      let sections = NSCollectionLayoutSection(group: group)
      
      let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
      sectionHeader.pinToVisibleBounds = true
      sections.boundarySupplementaryItems = [sectionHeader]
      sections.orthogonalScrollingBehavior =  Images.carImages[section].count > 1 ? .groupPaging : .continuous
      return sections
    }
    return layOut
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

    configureCollectionView()
    
}

  func configureCollectionView(){
    
    dataSource = UICollectionViewDiffableDataSource<Int, UIImage>(collectionView: self.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CollectionViewCell.self), for: indexPath) as! CollectionViewCell
      cell.imageView.image = itemIdentifier
      return cell
    })
    
    let header = UICollectionView.SupplementaryRegistration<CollectionReusableView>(elementKind: UICollectionView.elementKindSectionHeader, handler: { supplementaryView, elementKind, indexPath in
      supplementaryView.label.text = "Car Model \(indexPath.section)"
    })
    
    dataSource.supplementaryViewProvider = { (view, string, indexPath) in
      return  self.collectionView.dequeueConfiguredReusableSupplementary(using: header, for: indexPath)
    }
    
    var snapshot = NSDiffableDataSourceSnapshot<Int, UIImage>()
    
    let chunked = Images.carImages.enumerated() //.chunked(into: 10).enumerated()
    
    for data in chunked{
      snapshot.appendSections([data.offset])
      snapshot.appendItems(data.element, toSection: data.offset)
    }
    
    dataSource.apply(snapshot, animatingDifferences: true)
  }

}

extension ViewController: UICollectionViewDelegate{
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    print("didSelectItemAt --------------> \(indexPath)")
    
  }
  
}
