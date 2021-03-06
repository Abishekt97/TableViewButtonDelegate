//
//  ViewController.swift
//  WebView2
//
//  Created by Anil Kumar on 27/12/21.
//

import UIKit
import Foundation

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
      
//      var group = NSCollectionLayoutGroup(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(2), heightDimension: .fractionalHeight(0.35)))
      
//      if Images.carImages[section].count >= 4{
        
        let leadingItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.4)))
        leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

        let group1 = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .fractionalHeight(1)), subitem: leadingItem, count: 2)
        
        let group2 = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1)), subitem: group1, count: 2)
      let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1)), subitem: group2, count: 1)
        
//      }
//     else if Images.carImages[section].count > 1 {
//        let leadingItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
//        leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
//
//        let group1 = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)), subitem: leadingItem, count: 1)
//
//        group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalHeight(0.3), heightDimension: .fractionalHeight(0.3)), subitem: group1, count: 1)
//      }else{
//        let leadingItem1 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
//        leadingItem1.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
//        group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.4)), subitems: [leadingItem1])
//      }
        
      let sections = NSCollectionLayoutSection(group: group)
      sections.contentInsets = Images.carImages[section].count > 1 ? NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0) : .zero
      let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
      sectionHeader.pinToVisibleBounds = true
      sections.boundarySupplementaryItems = [sectionHeader]
      sections.orthogonalScrollingBehavior = .none
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
    
    let chunked = Images.carsImage //.chunked(into: 10).enumerated()
    
//    for data in chunked{
      snapshot.appendSections([0])
    snapshot.appendItems(chunked, toSection: 0)
//    }
    
    dataSource.apply(snapshot, animatingDifferences: true)
  }

}

extension ViewController: UICollectionViewDelegate{
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    print("didSelectItemAt --------------> \(indexPath)")
    
    // John Appleseed
    var user = User(firstName: "john", lastName: "appleseed")

    // John Sundell
    user.lastName = "sundell"
    
    
    debugPrint(user)
    debugPrint("user".capitalized)

//    var dat = Datam()
//    dat = Datam2()
//
//    dat = Datam()
//
  //  var dat1 = Datam2()
   // dat1 = Datam() as! Datam2

  }
  
}



class Datam: NSObject{
  
  @objc func printVal(){
    
    print("Datam---------------------------------")
    
  }
  
}

class Datam2: Datam{
  
  override init() {
    super.init()
    
 //   super.printVal()
    
    self.printVal()
        
  }
  
  override func printVal() {
    self.printVal()
    print("Datam2---------------------------------")
    
  }

}


@propertyWrapper struct Capitalized {
    var wrappedValue: String {
        didSet {
          wrappedValue = wrappedValue.uppercased()
        }
    }

    init(wrappedValue: String) {
        self.wrappedValue = wrappedValue.uppercased()
    }
}

struct User {
    @Capitalized var firstName: String
    @Capitalized var lastName: String
}


