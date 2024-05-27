//
//  UserViewModel.swift
//  WorkcareTimer
//
//  Created by Elian Richard on 26/05/24.
//

import Foundation

@Observable class UserViewModel: ObservableObject {
    var userId: String = ""
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    var isLoggedIn: Bool = false
}
