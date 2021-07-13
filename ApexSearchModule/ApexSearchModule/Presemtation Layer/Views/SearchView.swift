//
//  SearchView.swift
//  ApexSearchModule
//
//  Created by Olivier Rigault on 13/07/2021.
//

import SwiftUI
import ApexCoreUI
import ApexCore
import Resolver

public struct SearchView: View {
    
    @Injected var viewModel: SearchViewModel
    
    public init() {}
    
    public var body: some View {
        SearchNavigationViewBuilder()
            .withContentView(AnyView(content))
            .withTitle("Search")
            .withPlaceholder("Search apps")
            .onSearch { (searchTerm) in
                viewModel.search(with: searchTerm)
            }
            .build()
            .ignoresSafeArea()
    }
    
    private var content: some View {
        SearchContentViewBuilder()
            .withViewModel(viewModel)
            .build()
    }
}

struct SearchView_Previews: PreviewProvider {
    
    enum Dependencies {
        static var registerIdleState = { () -> Bool in
            Resolver.register { SearchViewModel() as SearchViewModel }
            return true
        }
        static var registerErrorState = { () -> Bool in
            Resolver.register { SearchViewModel(state: .error(DataError.invalidRequest)) as SearchViewModel }
            return true
        }
    }
    
    static var previews: some View {
        Group {
            if Dependencies.registerIdleState() {
                SearchView()
                    .previewDisplayName("default state = .idle")
            }
            if Dependencies.registerErrorState() {
                SearchView()
                    .previewDisplayName("state = .error")
            }
        }
    }
}
