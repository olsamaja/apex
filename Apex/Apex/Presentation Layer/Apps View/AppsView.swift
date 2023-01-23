//
//  AppsView.swift
//  Apex
//
//  Created by Olivier Rigault on 22/12/2021.
//

import SwiftUI
import ApexCoreUI
import ApexCore
import ApexSearchModule
import ApexViewModule
import UIPilot

enum AppRoute: Equatable {
    case home
    case details(AppSummary)
}

struct AppsView: View {

    @StateObject var pilot = UIPilot(initial: AppRoute.home)
    @ObservedObject var viewModel: AppsViewModel
    
    @State var showSelectStore = false
    @State var searchApps = ""

    var body: some View {
        UIPilotHost(pilot) { route in
            switch route {
            case .home:
                AppsContentView(viewModel: viewModel, searchApps: searchApps)
                    .searchable(text: $searchApps, placement: .navigationBarDrawer(displayMode: .always))
                    .navigationTitle("Applications")
                    .toolbar {
                        Button {
                            self.showSelectStore.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
            case .details(let appSummary):
                AppView(viewModel: AppViewModel(appSummary: appSummary))
            }
        }
        .sheet(isPresented: $showSelectStore, content: {
            SelectAppStoreView(viewModel: SelectAppStoreViewModel())
                .environmentObject(viewModel.favorites)
        })
        .ignoresSafeArea()
    }
}

struct AppsView_Previews: PreviewProvider {
    static var previews: some View {
        AppsView(viewModel: AppsViewModel())
    }
}
