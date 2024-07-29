//
//  ReviewScreen.swift
//  ApexViewModule
//
//  Created by Olivier Rigault on 08/11/2023.
//

import SwiftUI

public struct ReviewScreen: View {
    
    private let model: ReviewRowModel

    public init(model: ReviewRowModel) {
        self.model = model
    }
    
    public var body: some View {
        ScrollView(.vertical) {
            VStack() {
                StarsView(rating: Double(model.rating)!)
                VStack(alignment: .leading) {
                    HStack {
                        Grid(alignment: .leading) {
                            GridRow() {
                                Image(systemName: "person")
                                    .font(.title2)
                                Text(model.author)
                                    .font(.title2)
                                    .multilineTextAlignment(.leading)
                            }
                            GridRow() {
                                Text("Date:")
                                Text(model.updated)
                                    .font(.callout)
                            }
                            GridRow() {
                                Text("Version:")
                                Text(model.version)
                                    .font(.callout)
                            }
                        }
                        Spacer()
                    }
                    .padding(.vertical, 10)
                    Text(model.title)
                        .multilineTextAlignment(.leading)
                        .font(.headline)
                    Text(model.content)
                        .multilineTextAlignment(.leading)
                        .padding(.vertical, 3)
                }
                .padding(.vertical, 10)
                Spacer()
            }
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
        }
    }
}

#Preview("long title") {

    enum Constants {
        static let model = ReviewRowModel(review: Review(title: "This is awesome! Incredible super long title for this review!", author: "author", rating: "3", content: "This is a wonderful app, which never ceases to amaze me! Please keep the good work. Well done!", version: "4.5.6", updated: Date()))
    }
    
    return ReviewScreen(model: Constants.model)
}

#Preview("long content") {

    enum Constants {
        static let content =
        """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc eget leo accumsan libero vulputate interdum vel sed purus. Sed non dictum enim. Vestibulum accumsan iaculis dignissim. In hac habitasse platea dictumst. Etiam ac pulvinar tortor. Praesent et neque sed dui vestibulum vehicula sed vitae diam. Donec at mollis tellus. Nunc fermentum turpis id neque faucibus, ac interdum neque dignissim. Sed auctor turpis eget enim eleifend, vel scelerisque tellus dignissim. Sed sollicitudin interdum velit, nec ornare metus mollis nec.

        Praesent suscipit justo sit amet eros lobortis eleifend. Pellentesque enim magna, euismod ut mauris feugiat, mollis ullamcorper erat. Duis semper tincidunt metus, ac gravida ex consequat sed. Cras tristique mi nisi, non sagittis massa iaculis a. Maecenas cursus tempus ultricies. Curabitur malesuada vestibulum orci, eu consectetur risus sagittis sed. Aliquam fermentum erat id auctor condimentum. Aenean semper mi et nulla maximus suscipit. Sed aliquam risus consectetur placerat commodo. Duis at turpis eu nibh ullamcorper sollicitudin a id odio. Donec aliquam pulvinar tellus ut tincidunt. Mauris sodales gravida metus et aliquam. Duis dictum dictum tellus id accumsan. Cras volutpat arcu nibh, id auctor tellus tempus vel.

        Vestibulum quis ipsum leo. Vestibulum a diam in neque vulputate ultrices vitae quis libero. Maecenas vehicula vulputate magna non dictum. Vivamus cursus commodo est ut sodales. Proin eget lorem mi. Nunc lectus nulla, auctor quis justo at, facilisis ullamcorper elit. Nullam dui dui, pharetra in quam a, sagittis iaculis lacus. Nullam ex libero, rhoncus et justo id, iaculis facilisis felis. Nunc commodo mauris in tortor placerat, volutpat dapibus augue consectetur. Morbi tempus, mauris quis mollis condimentum, neque lacus rutrum justo, suscipit imperdiet diam lorem nec orci. Integer feugiat imperdiet quam, ut porttitor mauris pellentesque non.

        Proin ornare scelerisque tortor sed molestie. Sed faucibus lobortis gravida. Pellentesque posuere dolor eu massa cursus semper. Suspendisse eget lobortis risus, facilisis malesuada justo. Morbi interdum blandit aliquet. Vivamus nec eros luctus, maximus lacus sed, imperdiet odio. Nam posuere pharetra mauris facilisis volutpat. Sed purus odio, finibus sit amet rutrum vitae, auctor sit amet ante. Mauris eros nisi, lobortis gravida orci nec, pellentesque vestibulum quam. Vivamus vel dui ex. Sed molestie vehicula elit sit amet ornare. Mauris interdum egestas sem, eget luctus mi placerat et.

        Donec non dui dui. Suspendisse vel lacus vulputate, suscipit lorem vitae, maximus mi. In ac metus non mauris mattis cursus in eget libero. Praesent feugiat nulla a nunc posuere blandit. Ut rutrum lectus id ante tincidunt, tincidunt faucibus tortor accumsan. Nunc id nibh quis urna rutrum tincidunt. Nunc id enim orci. Phasellus quis congue dui, ac varius est. Etiam non viverra ipsum, id semper ligula. Interdum et malesuada fames ac ante ipsum primis in faucibus. Fusce faucibus nisl nec varius euismod. Nulla ullamcorper purus ex, non iaculis nisi condimentum eu
        """
    }
    
    return ReviewScreen(model: ReviewRowModel(review:
                                            Review(title: "Title",
                                                   author: "author",
                                                   rating: "3",
                                                   content: Constants.content,
                                                   version: "4.5.6",
                                                   updated: Date())))
}
