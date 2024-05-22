//
//  ApexApp.swift
//  Apex
//
//  Created by Olivier Rigault on 09/07/2021.
//
//  Use Binding to pass Published var from one class (view model) as Published property
//  in other class (view model) for binding to view of second view model
//  https://stackoverflow.com/questions/77009431/how-pass-published-var-from-one-class-view-model-as-published-property-in-othe

import SwiftUI

@main
struct ApexApp: App {

    @ObservedObject var viewModel = ApexViewModel()

    var body: some Scene {
        WindowGroup {
            TabView {
                HomeScreen(viewModel: HomeViewModel(storedApps: $viewModel.storedApps))
                    .tabItem {
                        Label("Home", systemImage: "star")
                    }
                AppsScreen(viewModel: AppsViewModel(storedApps: $viewModel.storedApps))
                    .tabItem {
                        Label("Applications", systemImage: "circle")
                    }
            }
        }
    }
}
