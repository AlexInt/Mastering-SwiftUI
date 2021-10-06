//
//  SwiftUI_signup.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/10/5.
//

import SwiftUI

struct SwiftUI_signup: View {
    
    //Subscriber
    @ObservedObject private var userRegistrationVM = UserRegistrationViewModel()
    
    var body: some View {
        VStack {
            Text("Create an account")
                .font(.system(.largeTitle, design: .rounded))
                .bold()
                .padding(.bottom, 30)
            
            FormField(fieldName: "Username", fieldValue: $userRegistrationVM.username)
            RequirementText(iconColor:userRegistrationVM.isUsernameLengthValid ? Color.secondary : Color(red: 251/255, green: 128/255, blue: 128/255), text: "A minimum of 4 characters", isStrikeThrough: userRegistrationVM.isUsernameLengthValid)
                .padding()
            
            FormField(fieldName: "Password", fieldValue: $userRegistrationVM.password, isSecure: true)
            VStack {
                RequirementText(iconName: "lock.open",
                                iconColor: userRegistrationVM.isPasswordLengthValid ? Color.secondary : Color(red: 251/255, green: 128/255, blue: 128/255),
                                text: "A minimum of 8 characters",
                                isStrikeThrough: userRegistrationVM.isPasswordLengthValid)
                RequirementText(iconName: "lock.open",
                                iconColor: userRegistrationVM.isPasswordCapitalLetter ? Color.secondary : Color(red: 251/255, green: 128/255, blue: 128/255),
                                text: "One uppercase letter",
                                isStrikeThrough: userRegistrationVM.isPasswordCapitalLetter)
            }
            .padding()
            
            FormField(fieldName: "Confirm Password", fieldValue: $userRegistrationVM.passwordConfirm, isSecure: true)
            RequirementText(iconColor: userRegistrationVM.isPasswordConfirmValid ? Color.secondary : Color(red: 251/255, green: 128/255, blue: 128/255),
                            text: "Your confirm password should be the same as password",
                            isStrikeThrough: userRegistrationVM.isPasswordConfirmValid)
                .padding()
                .padding(.bottom, 50)
            
            Button(action: {
                // Proceed to the next screen
            }) {
                Text("Sign Up")
                    .font(.system(.body, design: .rounded))
                    .foregroundColor(.white)
                    .bold()
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(LinearGradient(gradient: Gradient(colors: [Color(red: 251/255, green: 128/255, blue: 128/255), Color(red: 253/255, green: 193/255, blue: 104/255)]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
            }
            
            HStack {
                Text("Already have an account?")
                    .font(.system(.body, design: .rounded))
                    .bold()
                
                Button(action: {
                    // Proceed to Sign in screen
                }) {
                    Text("Sign in")
                        .font(.system(.body, design: .rounded))
                        .bold()
                        .foregroundColor(Color(red: 251/255, green: 128/255, blue: 128/255))
                }
            }.padding(.top, 50)
            
            Spacer()
        }
        .padding()
    }
}

struct SwiftUI_signup_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUI_signup()
    }
}

struct FormField: View {
    var fieldName = ""
    @Binding var fieldValue: String
    
    var isSecure = false
    
    var body: some View {
        
        VStack {
            if isSecure {
                SecureField(fieldName, text: $fieldValue)
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .padding(.horizontal)
                
            } else {
                TextField(fieldName, text: $fieldValue)                 .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .padding(.horizontal)
            }
            
            Divider()
                .frame(height: 1)
                .background(Color(red: 240/255, green: 240/255, blue: 240/255))
                .padding(.horizontal)
            
        }
    }
}

struct RequirementText: View {
    
    var iconName = "xmark.square"
    var iconColor = Color(red: 251/255, green: 128/255, blue: 128/255)
    
    var text = ""
    var isStrikeThrough = false
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(iconColor)
            Text(text)
                .font(.system(.body, design: .rounded))
                .foregroundColor(.secondary)
                .strikethrough(isStrikeThrough)
            Spacer()
        }
    }
}
