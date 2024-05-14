//
//  ApexApp.swift
//  Apex
//
//  Created by Olivier Rigault on 09/07/2021.
//

import SwiftUI

@main
struct ApexApp: App {
    var body: some Scene {
        WindowGroup {
            HomeScreen(viewModel: AppsViewModel())
        }
    }
}
