//
//  TableViewCell.swift
//  WebView
//
//  Created by Anil Kumar on 24/12/21.
//

import UIKit

class TableViewCell: UITableViewCell {

  lazy var button: UIButton! = {

    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.backgroundColor = .darkGray
    button.setTitleColor(.white, for: .normal)
    button.addTarget(self, action: #selector(didTaped(_:)), for: .touchUpInside)
    button.tag = 1
    button.setTitle("Tap", for: .normal)
    return button

  }()
  
  weak var delegate: CustomDelegate?

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    self.contentView.backgroundColor =  .clear
    self.backgroundColor =  .clear
    self.contentView.addSubview(button)

    self.button.heightAnchor.constraint(equalToConstant: 60).isActive = true
    self.button.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.66).isActive = true
    self.button.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
    self.button.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  @objc func didTaped(_ sender: UIButton){

    delegate?.didSelectedTheButton(sender.tag)
    
  }

}

protocol CustomDelegate: AnyObject{
  
  func didSelectedTheButton(_ index: Int)
  
}
