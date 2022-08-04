//
//  DataController.swift
//  Nguyen_Phuong_ColorMatcher
//
//  Created by Phuong  Nguyen on 03.08.22.
//

import Foundation
import CoreData

/*
 Regelt den Umgang mit den Daten
 */
class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Highscore")
        
    init(){
        container.loadPersistentStores { desc, error in
            // Doppelte Einträge werden beseitigt
            self.container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy

            if let error = error {
                print("Failed to load data\(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved")
        } catch {
            print("Could not save data")
        }
    }
    
    //Speichern der Daten
    func addScore(score: Int,  context: NSManagedObjectContext){
        let highscore = Highscore(context: context)
        highscore.highscore = Int64(score)
        save(context: context)
    }
}
