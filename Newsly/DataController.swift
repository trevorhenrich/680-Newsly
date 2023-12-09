//
//  DataController.swift
//  Newsly
//
//  Created by Trevor Henrich on 12/6/23.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "User")
    
    init () {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("error: \(error.localizedDescription)")
            }
        }
    }

}
