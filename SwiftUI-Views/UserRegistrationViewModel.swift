//
//  UserRegistrationViewModel.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/10/5.
//

import Foundation
import Combine


/*
 Publisher and Subscriber are the two core elements of the framework. With Combine, Publisher sends events and Subscriber subscribes to receive values from that Publisher.
 */
class UserRegistrationViewModel: ObservableObject {
    
    /*
     All these properties are annotated with @Published because we want to notify the subscribers whenever there is a value change and perform the validation accordingly.
     */
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
        /*
         The Combine framework provides two built-in subscribers: sink and assign. For sink , it creates a general purpose subscriber to receive values. assign allows you to create another type of subscriber that can update a specific property of an object.
         */
        
        /*
         Since we're subscribing to the change of UI events, we call the receive(on:) function to ensure the subscriber receives values on the main thread (i.e. RunLoop.main ).
         */
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
