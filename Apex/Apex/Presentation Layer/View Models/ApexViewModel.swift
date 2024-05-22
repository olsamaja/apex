//
//  ApexViewModel.swift
//  Apex
//
//  Created by Olivier Rigault on 22/05/2024.
//

import Combine
import ApexCore
import ApexNetwork

public final class ApexViewModel: ObservableObject {
    
    @Published var storedApps = StoredApps()
}
