//
//  OnboardingView.swift
//  WorkcareTimer
//
//  Created by Elian Richard on 22/05/24.
//

import SwiftUI
import AuthenticationServices

struct OnboardingView: View {
    @ObservedObject var userViewModel: UserViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ZStack (alignment: .center) {
                Image(.onboardingBg)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                VStack{
                    Text("Workcare Timer")
                        .font(.largeTitle)
                    Text("Productivity. Reinvented.")
                        .font(.title2)
                    Spacer().frame(height: 50)
                    Button {
                        withAnimation(.easeInOut(duration: 1)){
                            userViewModel.isLoggedIn = true
                        }
                    } label: {
                        Text("Sign in with Apple")
                    }
                    .background()
                    
                    SignInWithAppleButton(.signIn, onRequest: configure, onCompletion: handleSignIn)
                }
                .padding(20)
                .frame(width: geometry.size.width * 0.85, height: geometry.size.height * 0.8)
                .background(.blackBg)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func configure(_ request: ASAuthorizationAppleIDRequest) {
        request.requestedScopes = [.fullName, .email]
    }
    
    private func handleSignIn (_ result: Result<ASAuthorization, Error>) {
        switch result {
        case .success(let auth):
            switch auth.credential {
            case let credential as ASAuthorizationAppleIDCredential:
                let userId = credential.user
                let email = credential.email
                let firstName = credential.fullName?.givenName
                let lastName = credential.fullName?.familyName
                
                userViewModel.userId = userId
                userViewModel.email = email ?? ""
                userViewModel.firstName = firstName ?? ""
                userViewModel.lastName = lastName ?? ""
                userViewModel.isLoggedIn = true
                break
            default:
                break
            }
        case .failure(let error):
            print(error)
        }
    }
}

#Preview {
    OnboardingView(userViewModel: UserViewModel())
        .frame(maxWidth: 800, maxHeight: 500)
}
