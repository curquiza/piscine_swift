//
//  ViewController.swift
//  testCoreData
//
//  Created by Clementine URQUIZAR on 4/3/19.
//  Copyright © 2019 Clementine URQUIZAR. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var personArray: [Person] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // CREATE
        print("CREATE")
        var newPerson: Person!
        newPerson = Person(context: context)
        newPerson.name = "Toto"
        newPerson.age = 26
        saveContext()
        
        // GET
        print("GET")
        getPersons()
        
        // UPDATE
        print("UPDATE")
        personArray.last?.setValue("Titi", forKey: "name")
        saveContext()
        getPersons()
        
        // DELETE
        print("DELETE")
        context.delete(personArray.last!)
        saveContext()
        getPersons()
    }

    func saveContext() {
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
    }
    
    func getPersons() {
        let request: NSFetchRequest<Person> = Person.fetchRequest()
        do {
            self.personArray = try context.fetch(request)
        } catch {
            print("Error fetching data \(error)")
        }
        print(self.personArray)
    }

}

