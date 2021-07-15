//
//  SearchNavigationView.swift
//  ApexCoreUI
//
//  Created by Olivier Rigault on 09/07/2021.
//

import SwiftUI
import ApexCore

public struct SearchNavigationView: UIViewControllerRepresentable {
    
    public func makeCoordinator() -> Coordinator {
        return SearchNavigationView.Coordinator(parent: self)
    }
    
    var view: AnyView
    let useLargeTitle: Bool
    let title: String?
    let placeholder: String?
    
    // onSearch and onCancel closures
    var onSearch: ((String) -> ())?
    var onCancel: (() -> ())?
    
    public init(view: AnyView,
         useLargeTitle: Bool,
         title: String?,
         placeholder: String?,
         onSearch: ((String) -> ())?,
         onCancel: (() -> ())?) {
        self.view = view
        self.title = title
        self.placeholder = placeholder
        self.useLargeTitle = useLargeTitle
        self.onSearch = onSearch
        self.onCancel = onCancel
    }
    
    // Integrating UIKot navigation controllerwith SwiftUI View...
    public func makeUIViewController(context: Context) -> UINavigationController {
        
        let childView = UIHostingController(rootView: view)
        let controller = UINavigationController(rootViewController: childView)
        
        controller.navigationBar.topItem?.title = title
        controller.navigationBar.prefersLargeTitles = useLargeTitle
        
        let searchController = UISearchController()
        searchController.searchBar.placeholder = placeholder
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = context.coordinator
        
        controller.navigationBar.topItem?.hidesSearchBarWhenScrolling = false
        controller.navigationBar.topItem?.searchController = searchController
        
        return controller
    }
    
    public func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        uiViewController.navigationBar.topItem?.title = title
        uiViewController.navigationBar.prefersLargeTitles = useLargeTitle
        uiViewController.navigationBar.topItem?.searchController?.searchBar.placeholder = placeholder
    }
    
    public class Coordinator: NSObject, UISearchBarDelegate {
        
        var parent: SearchNavigationView
        
        init(parent: SearchNavigationView) {
            self.parent = parent
        }
        
        public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            guard let onSearch = parent.onSearch else { return }
            onSearch(searchText)
        }
        
        public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            guard let onCancel = parent.onCancel else { return }
            onCancel()
        }
    }
}

public class SearchNavigationViewBuilder: BuilderProtocol {

    private var contentView: AnyView?
    private var useLargeTitle: Bool = true
    private var title: String?
    private var placeholder: String?
    private var onSearch: ((String) -> ())?
    private var onCancel: (() -> ())?
    
    public init() {}
    
    public func withContentView(_ view: AnyView) -> SearchNavigationViewBuilder {
        self.contentView = view
        return self
    }
    
    public func withTitle(_ title: String) -> SearchNavigationViewBuilder {
        self.title = title
        return self
    }
    
    public func withPlaceholder(_ placeholder: String) -> SearchNavigationViewBuilder {
        self.placeholder = placeholder
        return self
    }
    
    public func withUseLargeTitle(_ useLargeTitle: Bool) -> SearchNavigationViewBuilder {
        self.useLargeTitle = useLargeTitle
        return self
    }
    
    public func onSearch(_ onSearch: @escaping (String) -> ()) -> SearchNavigationViewBuilder {
        self.onSearch = onSearch
        return self
    }
    
    public func onCancel(_ onCancel: @escaping () -> ()) -> SearchNavigationViewBuilder {
        self.onCancel = onCancel
        return self
    }
    
    @ViewBuilder
    public func build() -> some View {
        if let view = contentView {
            SearchNavigationView(
                view: view,
                useLargeTitle: useLargeTitle,
                title: title,
                placeholder: placeholder,
                onSearch: onSearch,
                onCancel: onCancel)
        } else {
            MessageViewBuilder()
                .withSymbol("xmark.octagon.fill")
                .withMessage("Sorry, there is no content.")
                .build()
        }
    }
}

public class SearchNavigationView_Previews: PreviewProvider {
    
    public static var previews: some View {
        Group {
            SearchNavigationViewBuilder()
                .withTitle("Test")
                .withContentView(
                    AnyView(MessageViewBuilder()
                                .withMessage("This is some test content.")
                                .build()
                                .background(Color.blue)))
                .build()
                .previewDisplayName("Test content")
            SearchNavigationViewBuilder()
                .build()
                .previewDisplayName("No content")
        }
    }
}
