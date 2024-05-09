//
//  SelectStoreView.swift
//  ApexSearchModule
//
//  Created by Olivier Rigault on 19/11/2023.
//

import SwiftUI
import ApexCore
import ApexCoreUI
import ApexStoreModule

struct SelectStoreView: View {
    
    @StateObject var viewModel: SearchApplicationsViewModel
    @State var showSelectStore = false

    @ViewBuilder
    var body: some View {
        if let store = AppStoreManager.defaultStore {
            HStack {
                Text(store.name)
                    .font(.callout)
                Spacer()
                Button {
                    print(viewModel.state)
                    self.showSelectStore.toggle()
//                    viewModel.send(event: .onPerform(.search(viewModel.term, Store(code: "FR", name: "France"))))
                } label: {
                    Text("Change Store")
                        .font(.callout)
                }
            }
            .sheet(isPresented: $showSelectStore, content: {
                SelectAppStoreView(viewModel: SelectAppStoreViewModel())
//                    .environmentObject(viewModel.favorites)
            })
        } else {
            Button {
                print("no store selected")
            } label: {
                Text("Select Store")
            }
        }
    }
}

//struct SelectStoreView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            SelectStoreView()
//                .sizeThatFitPreview(with: "Light Theme")
//            SelectStoreView()
//                .sizeThatFitPreview(with: "Dark Theme")
//                .preferredColorScheme(.dark)
//        }
//    }
//}
