//
//  SearchAppsView.swift
//  ApexSearchModule
//
//  Created by Olivier Rigault on 25/11/2021.
//

import SwiftUI

import SwiftUI
import ApexCoreUI
import ApexCore
import Resolver
import ApexSettingsModule

public struct SearchAppsView: View {
    
    let viewModel: SearchAppsViewModel
    
    public init(viewModel: SearchAppsViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        SearchNavigationViewBuilder()
            .withContentView(AnyView(content))
            .withUseLargeTitle(false)
            .withPlaceholder("Search apps")
            .onSearch { (searchTerm) in
                viewModel.search(with: searchTerm)
            }
            .build()
            .ignoresSafeArea()
    }
    
    private var content: some View {
        SearchAppsContentViewBuilder()
            .withViewModel(viewModel)
            .build()
    }
}

//struct SearchAppsView_Previews: PreviewProvider {
//
//    enum Dependencies {
//        static var registerIdleState = { () -> Bool in
//            Resolver.register { SearchAppsViewModel() as SearchAppsViewModel }
//            return true
//        }
//        static var registerErrorState = { () -> Bool in
//            Resolver.register { SearchAppsViewModel(state: .error(DataError.invalidRequest)) as SearchAppsViewModel }
//            return true
//        }
//    }
//
//    static var previews: some View {
//        Group {
//            if Dependencies.registerIdleState() {
//                SearchAppsView()
//                    .previewDisplayName("default state = .idle")
//            }
//            if Dependencies.registerErrorState() {
//                SearchAppsView()
//                    .previewDisplayName("state = .error")
//            }
//        }
//    }
//}
