//
//  AppFavorites.swift
//  ApexCore
//
//  Created by Olivier Rigault on 07/12/2021.
//

import Foundation

public class AppFavorites: ObservableObject {

    private var apps: Set<Int>
    private let saveKey = "Favorites"

    public init() {
        // load our saved data
        OLLogger.info("Load favorites")

        // still here? Use an empty array
        self.apps = []
    }

    // returns true if our set contains this resort
    func contains(_ app: AppSummary) -> Bool {
        apps.contains(app.trackId)
    }

    // adds the resort to our set, updates all views, and saves the change
    func add(_ app: AppSummary) {
        objectWillChange.send()
        apps.insert(app.trackId)
        save()
    }

    // removes the resort from our set, updates all views, and saves the change
    func remove(_ app: AppSummary) {
        objectWillChange.send()
        apps.remove(app.trackId)
        save()
    }

    public func save() {
        // write out our data
        OLLogger.info("Save favorite")
    }
}
