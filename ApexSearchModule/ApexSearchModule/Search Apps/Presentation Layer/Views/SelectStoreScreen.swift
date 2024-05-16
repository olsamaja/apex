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

struct SelectStoreScreen: View {
    
    @StateObject var viewModel: SearchApplicationsViewModel
    @State var showSelectStore = false
    @ObservedObject var selectedStore = SelectedStore()

    @ViewBuilder
    var body: some View {
            HStack {
            Text(selectedStore.current.name)
                .font(.callout)
            Spacer()
            Button {
                print(viewModel.state)
                self.showSelectStore.toggle()
            } label: {
                Text("Change Store")
                    .font(.callout)
            }
        }
        .sheet(isPresented: $showSelectStore, content: {
            ChangeStoreScreen()
                .environmentObject(selectedStore)
        })
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
