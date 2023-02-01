//
//  ViewController.swift
//  CoreDataExample
//
//  Created by chaitanya on 2/1/23.
//

import UIKit
import CoreData

// MARK: - CRUD - Create,Retrive,Update, Delete


class ViewController: UIViewController {

    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var usernameTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func createBTn(_ sender: Any) {
        createcoreData()
    }
    
    @IBAction func retriveBtn(_ sender: Any) {
        retrivecoreData()
    }
    
    // MARK: - Core Data Creating
    func createcoreData(){
        
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedcontext = appdelegate.persistentContainer.viewContext
        
        let userEntity = NSEntityDescription.entity(forEntityName: "User", in: managedcontext)!
        
        let user = NSManagedObject(entity: userEntity, insertInto: managedcontext)
        
        
        user.setValue(usernameTxt.text, forKey: "username")
        user.setValue(emailTxt.text, forKey: "email")
        user.setValue(passwordTxt.text, forKey: "password")
        
        print(user)
        
        do {
            try managedcontext.save()
        }catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
        
        
    }
    
    // MARK: - Core Data Retriving
    
    func retrivecoreData(){
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appdelegate.persistentContainer.viewContext
        
        let fetchResult = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        do {
            let result = try managedContext.fetch(fetchResult)
            
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "username") as! String)
                print(data.value(forKey: "email") as! String)
                print(data.value(forKey: "password") as! String)
            }
        }catch {
            print("failed")
        }
        
        
    }
}

