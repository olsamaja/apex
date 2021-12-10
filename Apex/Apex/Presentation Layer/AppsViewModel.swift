//
//  AppsViewModel.swift
//  Apex
//
//  Created by Olivier Rigault on 24/11/2021.
//

import Combine
import ApexCore

public final class AppsViewModel: ObservableObject {

    @Published var term = ""
    @Published var favorites = AppFavorites()

    func search(with term: String) {
        OLLogger.info("Search term: \(term)")
        self.term = term
    }
}
