//
//  SearchNavigationView.swift
//  ApexCoreUI
//
//  Created by Olivier Rigault on 09/07/2021.
//

import SwiftUI
import ApexCore

public struct SearchNavigationView<ContentView: View>: UIViewControllerRepresentable {

    var view: ContentView
    let useLargeTitle: Bool
    let title: String?
    let placeholder: String?
    
    var onSearch: ((String) -> ())?
    var onCancel: (() -> ())?
    
    let barButtonItemTitle: String?
    let barButtonItemImage: String?
    var onBarButtonItem: (() -> ())?

    public init(view: ContentView,
         useLargeTitle: Bool,
         title: String?,
         placeholder: String?,
         onSearch: ((String) -> ())?,
         onCancel: (() -> ())?,
         barButtonItemTitle: String? = nil,
         barButtonItemImage: String? = nil,
         onBarButtonItem: (() -> ())? = nil) {
        self.view = view
        self.title = title
        self.placeholder = placeholder
        self.useLargeTitle = useLargeTitle
        self.onSearch = onSearch
        self.onCancel = onCancel
        self.barButtonItemTitle = barButtonItemTitle
        self.barButtonItemImage = barButtonItemImage
        self.onBarButtonItem = onBarButtonItem
    }

    // Integrating UIKit navigation controllerwith SwiftUI View...
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
        
        let target = context.coordinator
        let action = #selector(context.coordinator.onBarButtonItemTapped(_:))
        
        if let button = barButtonItem(image: barButtonItemImage, title: barButtonItemTitle, target: target, action: action) {
            childView.navigationItem.rightBarButtonItem = button
        }

        return controller
    }
    
    private func barButtonItem(image: String?,
                               title: String?,
                               target: SearchNavigationView.Coordinator,
                               action: Selector) -> UIBarButtonItem? {
        
        let style = UIBarButtonItem.Style.plain
        
        if let image = image {
            return UIBarButtonItem(image: UIImage(systemName: image), style: style, target: target, action: action)
        }
        
        if let title = title {
            return UIBarButtonItem(title: title, style: style, target: target, action: action)
        }
        
        return nil
    }
    
    public func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        uiViewController.navigationBar.topItem?.title = title
        uiViewController.navigationBar.prefersLargeTitles = useLargeTitle
        uiViewController.navigationBar.topItem?.searchController?.searchBar.placeholder = placeholder
    }
    
    public func makeCoordinator() -> Coordinator {
        return SearchNavigationView.Coordinator(parent: self)
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
        
        @objc func onBarButtonItemTapped(_ sender : UIButton) {
            guard let onBarButtonItem = parent.onBarButtonItem else { return }
            onBarButtonItem()
        }
    }
}

public class SearchNavigationViewBuilder<ContentView: View>: BuilderProtocol {

    private var contentView: ContentView?
    private var useLargeTitle: Bool = true
    private var title: String?
    private var placeholder: String?
    private var onSearch: ((String) -> ())?
    private var onCancel: (() -> ())?
    private var barButtonItemTitle: String?
    private var barButtonItemImage: String?
    private var onBarButtonItem: (() -> ())?

    public init() {}
    
    public func withContentView(_ view: ContentView) -> SearchNavigationViewBuilder {
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
    
    public func withBarButtonItemTitle(_ title: String) -> SearchNavigationViewBuilder {
        self.barButtonItemTitle = title
        return self
    }
    
    public func withBarButtonItemImage(_ name: String) -> SearchNavigationViewBuilder {
        self.barButtonItemImage = name
        return self
    }

    public func onBarButtonItem(_ onBarButtonItem: @escaping () -> ()) -> SearchNavigationViewBuilder {
        self.onBarButtonItem = onBarButtonItem
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
                onCancel: onCancel,
                barButtonItemTitle: barButtonItemTitle,
                barButtonItemImage: barButtonItemImage,
                onBarButtonItem: onBarButtonItem)
        } else {
            MessageViewBuilder()
                .withSymbol("xmark.octagon.fill")
                .withMessage("Sorry, there is no content.")
                .build()
        }
    }
}

public class SearchNavigationView_Previews: PreviewProvider {
    
    enum Constants {
        static let content = Text("Content")
    }
    
    public static var previews: some View {
        Group {
            SearchNavigationViewBuilder()
                .withTitle("Test")
                .withContentView(Constants.content)
                .build()
                .previewDisplayName("Large title")
            SearchNavigationViewBuilder()
                .withTitle("Test")
                .withUseLargeTitle(false)
                .withContentView(Constants.content)
                .build()
                .previewDisplayName("Inline display")
            SearchNavigationViewBuilder()
                .withUseLargeTitle(false)
                .withContentView(Constants.content)
                .build()
                .previewDisplayName("No title")
        }
    }
}
