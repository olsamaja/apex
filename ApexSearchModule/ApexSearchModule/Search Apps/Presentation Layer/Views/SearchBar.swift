//
//  SearchBar.swift
//  ApexSearchModule
//
//  Created by Olivier Rigault on 25/11/2021.
//
//  References:
//  - https://www.appcoda.com/swiftui-search-bar/

import SwiftUI
import ApexCoreUI

struct SearchBar: View {
    
    @Binding var text: String
    @State private var isEditing = false
 
    var body: some View {
        HStack {
 
            TextField("Search", text: $text)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color.searchBarBackground)
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)

                        if isEditing {
                            Button(action: {
                                self.text = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }
 
            if isEditing {
                Button(action: {
                    self.isEditing = false
                    self.text = ""
 
                }) {
                    Text("Cancel")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
        }
    }
}
struct SearchBar_Previews: PreviewProvider {
    
    static var previews: some View {
        SearchBar(text: .constant(""))
            .sizeThatFitPreview(with: "Light")
        SearchBar(text: .constant("Amazon"))
            .sizeThatFitPreview(with: "Light with text")
        SearchBar(text: .constant(""))
            .sizeThatFitPreview(with: "Dark")
            .preferredColorScheme(.dark)
        SearchBar(text: .constant("NewDay"))
            .sizeThatFitPreview(with: "Dark with some text")
            .preferredColorScheme(.dark)
    }
}
