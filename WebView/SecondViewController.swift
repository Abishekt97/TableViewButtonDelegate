//
//  SecondViewController.swift
//  WebView
//
//  Created by Anil Kumar on 24/12/21.
//

import UIKit

class SecondViewController: UIViewController {

  lazy var tableView: UITableView! = {
      let tableView = UITableView(frame: .zero, style: .grouped)
      tableView.translatesAutoresizingMaskIntoConstraints = false
      tableView.register(TableViewCell.self, forCellReuseIdentifier: String(describing: TableViewCell.self))
      tableView.backgroundColor   =   .white
      tableView.separatorColor    =   .clear
      tableView.delegate          =   self
      tableView.dataSource        =   self
      return tableView
  }()
  
  let dictionaryData = [1: ["one"], 2: ["one","two"], 3: ["one","two","three"]]

    override func viewDidLoad() {
        super.viewDidLoad()
      
      self.view.backgroundColor = .white
      
      //
      self.view.addSubview(self.tableView)
      
      NSLayoutConstraint.activate([
      
        self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
        self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
        self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
        self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),

      ])

    }
    
}

extension SecondViewController: UITableViewDelegate, UITableViewDataSource{
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return dictionaryData.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dictionaryData[section+1]?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TableViewCell.self), for: indexPath) as! TableViewCell
    cell.button.tag = indexPath.row
    cell.delegate = self
    cell.button.setTitle("Button \(indexPath.section), \(dictionaryData[indexPath.section+1]?[indexPath.row] ?? "")", for: .normal)
    return cell
    
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
  
}

extension SecondViewController: CustomDelegate{
  
  func didSelectedTheButton(_ index: Int) {
    
    let vc = ViewController()
    vc.currentcase = .tapped(index)
    self.navigationController?.pushViewController(vc, animated: true)
    
  }
  
}
