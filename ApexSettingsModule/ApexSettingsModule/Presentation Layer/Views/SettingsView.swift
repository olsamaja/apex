//
//  SettingsView.swift
//  ApexSettingsModule
//
//  Created by Olivier Rigault on 18/11/2021.
//

import SwiftUI
import ApexCountryModule

public struct SettingsView: View {
    
    @Environment(\.presentationMode)
    var presentationMode: Binding<PresentationMode>

    @ObservedObject var viewModel = SettingsViewModel()
    
    public init() {}
    
    public var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Store")) {
                    NavigationLink(
                        destination:
                            CountriesView()
                                .navigationTitle("Select a Store"),
                        label: {
                            CurrentCountryView()
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
