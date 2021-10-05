//
//  UserRegistrationViewModel.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/10/5.
//

import Foundation
import Combine

class UserRegistrationViewModel: ObservableObject {
    //Input
    @Published var username = ""
    @Published var password = ""
    @Published var passwordConfirm = ""
    
    // Output
    @Published var isUsernameLengthValid = false
    @Published var isPasswordLengthValid = false
    @Published var isPasswordCapitalLetter = false
    @Published var isPasswordConfirmValid = false
    
    private var cancellableSet: Set<AnyCancellable> = []
    //Because cancellableSet is defined as a property of the class, the cleanup and cancellation of the subscription will happen when the class is deinitialized.
    
    init() {
        $username
            .receive(on: RunLoop.main)
            .map{ $0.count >= 4 }
            .assign(to: \.isUsernameLengthValid, on: self)
            .store(in: &cancellableSet)
        //The assign function, which creates the subscriber, returns you with a cancellable instance.
        // The store function lets us save the cancellable reference into a set for later cleanup
        
        $password
            .receive(on: RunLoop.main)
            .map{ $0.count >= 8 }
            .assign(to: \.isPasswordLengthValid, on: self)
            .store(in: &cancellableSet)
        
        $password
            .receive(on: RunLoop.main)
            .map{
                let pattern = "[A-Z]"
                if let _ = $0.range(of: pattern, options: .regularExpression) {
                    return true
                } else {
                    return false
                }
            }
            .assign(to: \.isPasswordCapitalLetter, on: self)
            .store(in: &cancellableSet)
        
        Publishers.CombineLatest($password, $passwordConfirm)
            .receive(on: RunLoop.main)
            .map{ !$1.isEmpty && ($0 == $1) }
            .assign(to: \.isPasswordConfirmValid, on: self)
            .store(in: &cancellableSet)
    }
    
}
