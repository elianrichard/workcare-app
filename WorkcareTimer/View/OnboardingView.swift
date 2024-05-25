//
//  OnboardingView.swift
//  WorkcareTimer
//
//  Created by Elian Richard on 22/05/24.
//

import SwiftUI
import AuthenticationServices

struct OnboardingView: View {
    @Binding public var isOnboardingDone: Bool
    
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
                            isOnboardingDone = true
                        }
                    } label: {
                        Text("Sign in with Apple")
                    }
                    .background()
                    SignInWithAppleButton(onRequest: { request in
                        print("request")
                    }, onCompletion: { result in
                        print("auth done")
                    })
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
}

#Preview {
    OnboardingView(isOnboardingDone: .constant(false))
        .frame(maxWidth: 800, maxHeight: 500)
}
