//
//  ViewController.swift
//  CoreDataWorkGround
//
//  Created by Anil Kumar on 28/12/21.
//

import UIKit
import CoreData

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    insertData()
    retriveData()
    debugPrint("---------------------------------------------------------------------------------------------------")
   updateData()
    retriveData()
    debugPrint("---------------------------------------------------------------------------------------------------")
   deleteData()
    retriveData()
    debugPrint("---------------------------------------------------------------------------------------------------")
 }

  func insertData() {
    
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return  }
    
    let context = appDelegate.persistentContainer.viewContext
    
    guard let userEntity = NSEntityDescription.entity(forEntityName: "FirstClass", in: context) else { return  }
    
    let ranks = [6,3,1,0,2,7,4,9,5,8]
    
    for i in ranks.enumerated(){
      
      let user = NSManagedObject(entity: userEntity, insertInto: context)
      
      user.setValue("student \(i.offset + 1)", forKey: "name")
      user.setValue(i.element + 1, forKey: "rank")
      user.setValue(Date(), forKey: "dob")
      user.setValue(NSUUID(), forKey: "id")

    }
    
    do {
      try context.save()
    }catch(let errors){
      debugPrint(errors.localizedDescription)
    }
    
  }
  
  func retriveData() {
    
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return  }
    
    let context = appDelegate.persistentContainer.viewContext
    
    let fetchResult = NSFetchRequest<FirstClass>(entityName: String(describing: FirstClass.self))
    fetchResult.sortDescriptors = [NSSortDescriptor(key: "rank", ascending: true)]
    
    do {
      let data = try context.fetch(fetchResult)
      
      debugPrint("Total number of count", data.count)
      
      for res in data{
        debugPrint(res.name as Any, res.rank as Any, res.id as Any)
      }
    } catch let errors {
      debugPrint(errors.localizedDescription)
    }

  }
  
  func updateData() {
    
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return  }
    
    let context = appDelegate.persistentContainer.viewContext

    let fetchResult = NSFetchRequest<FirstClass>(entityName: String(describing: FirstClass.self))
    
    fetchResult.predicate = NSPredicate(format: "rank IN %@",  [6,3,1,0,2,7,4,9,5,8])
    
    do {
      let result = try context.fetch(fetchResult)
      
      for res in result{
        
        res.setValue(33, forKey: "rank")
        
      }
      
    } catch let errore {
      debugPrint(errore.localizedDescription)
    }
    
  }

  func deleteData() {
    
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return  }
    
    let context = appDelegate.persistentContainer.viewContext

    let fetchResult = NSFetchRequest<FirstClass>(entityName: String(describing: FirstClass.self))

    do {
      let result = try context.fetch(fetchResult)
      
      for res in result{
        context.delete(res)
      }
      
      try context.save()
      
    } catch let errore {
      debugPrint(errore.localizedDescription)
    }
    
  }
  
}

