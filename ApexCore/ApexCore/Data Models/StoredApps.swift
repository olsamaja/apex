//
//  StoredApps.swift
//  ApexCore
//
//  Created by Olivier Rigault on 07/12/2021.
//

import Foundation

public class StoredApps: ObservableObject {

    private enum Constants {
        static let storedAppsKey = "StoredApps"
    }
    
    let defaults: UserDefaults
    @Published public var apps: Set<AppSummary>
    
    public var all: [AppSummary] {
        apps.map { $0 }
    }
    
    public var favorites: [AppSummary] {
        apps.map { $0 }.filter { $0.isFavorite }
    }
    
    public init(defaults: UserDefaults = UserDefaults.standard) {
        self.defaults = defaults
        self.apps = defaults.customObject(forKey: Constants.storedAppsKey) ?? Set<AppSummary>()
    }
    
    public init(defaults: UserDefaults = UserDefaults.standard, apps: Set<AppSummary>) {
        self.defaults = defaults
        self.apps = apps
    }

    // returns true if our set contains this app
    public func contains(_ app: AppSummary) -> Bool {
        apps.contains(app)
    }

    // adds the app to our set, updates all views, and saves the change
    public func add(_ app: AppSummary) {
        objectWillChange.send()
        apps.insert(app)
        save()
    }

    // removes the a[[ from our set, updates all views, and saves the change
    public func remove(_ app: AppSummary) {
        objectWillChange.send()
        apps.remove(app)
        save()
    }

    public func save() {
        // write out our data
        defaults.setCustomObject(apps, forKey: Constants.storedAppsKey)
    }
}
