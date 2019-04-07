//
//  Article+CoreDataClass.swift
//  
//
//  Created by Clementine URQUIZAR on 4/4/19.
//
//

import Foundation
import CoreData

@objc(Article)
public class Article: NSManagedObject {
    
    override public var description: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy, HH:mm"
        
        
        let mytitle = "\nTitle:           \(title != nil ? title!.uppercased() : "NIL")\n"
        let mycontent = "Content:         \(content != nil ? content! : "NIL")\n"
        let created = "Created on:      \(creation_date != nil ? dateFormatter.string(from: creation_date! as Date) : "NIL")\n"
        let updated = "Last edited on:  \(modif_date != nil ? dateFormatter.string(from: modif_date! as Date) : "NIL")\n"
        let lang =    "Language:        \(language != nil ? language! : "NIL")\n"
        
        let str = mytitle + mycontent + created + updated + lang
        return str
    }

}
