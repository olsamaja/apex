//
//  SettingsView.swift
//  ApexSettingsModule
//
//  Created by Olivier Rigault on 18/11/2021.
//

import SwiftUI
import ApexStoreModule

public struct SettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @ObservedObject var viewModel = SettingsViewModel()
    @ObservedObject var selectedStore = SelectedStore()

    public init() {}
    
    public var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Store")) {
                    NavigationLink(
                        destination:
                            StoresView()
                                .environmentObject(selectedStore)
                                .navigationTitle("Select a Store"),
                        label: {
                            SelectedStoreView()
                                .environmentObject(selectedStore)
                        }
                    )
                }
            }
            .navigationBarTitle("Settings")
            .navigationBarItems(trailing: Button("Done", action: {
                self.presentationMode.wrappedValue.dismiss()
            }))
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
