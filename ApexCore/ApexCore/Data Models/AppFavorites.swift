//
//  AppFavorites.swift
//  ApexCore
//
//  Created by Olivier Rigault on 07/12/2021.
//

import Foundation

public class AppFavorites: ObservableObject {

    private enum Constants {
        static let favoritesKey = "Favorites"
    }
    
    public static let shared = AppFavorites()
    let defaults: UserDefaults
    var apps: Set<AppSummary>
    
    public var allFavorites: [AppSummary] {
        apps.map { $0 }
    }
    
    public init(defaults: UserDefaults = UserDefaults.standard) {
        self.defaults = defaults
        self.apps = defaults.customObject(forKey: Constants.favoritesKey) ?? Set<AppSummary>()
    }

    // returns true if our set contains this resort
    func contains(_ app: AppSummary) -> Bool {
        apps.contains(app)
    }

    // adds the resort to our set, updates all views, and saves the change
    public func add(_ app: AppSummary) {
        objectWillChange.send()
        apps.insert(app)
        save()
    }

    // removes the resort from our set, updates all views, and saves the change
    public func remove(_ app: AppSummary) {
        objectWillChange.send()
        apps.remove(app)
        save()
    }

    public func save() {
        // write out our data
        defaults.setCustomObject(apps, forKey: Constants.favoritesKey)
    }
}
