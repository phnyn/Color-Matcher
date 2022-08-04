//
//  ColorMatcherApp.swift
//  ColorMatcher
//
//  Created by Phuong  Nguyen on 07.07.22.
//

import SwiftUI

@main
struct ColorMatcherApp: App {
    // Damit man DataController und Daten über ganze Umgebung benutzen kann
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup{
            ContentView().environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
