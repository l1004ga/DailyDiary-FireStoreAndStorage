//
//  BioLoginView.swift
//  DailyDiary
//
//  Created by dev on 2023/03/07.
//

import SwiftUI
//지문 및 안면인식을 통해 잠금해제
import LocalAuthentication

struct BioLoginView: View {
    
    @EnvironmentObject var authVM : AuthVM
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        // check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // it's possible, so go ahead and use it
            let reason = "We need to unlock your data."
            
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, authenticationError in
                // authentication has now completed
                if success {
                    authVM.page = "Page2"
                    //firebase 바이오 로그인 체크
                } else {
                    print("실패")
                    // there was a problem
                }
            }
        } else {
            // no biometrics
        }
    }
    
    var body: some View {
        ZStack {
            Color("MainColor").ignoresSafeArea()
            VStack{
                Spacer()
                
                Button {
                    authenticate()
                } label: {
                    Image(systemName: "faceid")
                        .resizable()
                        .frame(width: 130, height: 130)
                }
                
                Spacer()
                
                Button {
                    authVM.page = "Page4"
                } label: {
                    Text("일반 로그인하기")
                        .foregroundColor(.white)
                        .font(.custom("KyoboHandwriting2021sjy", size: 25))
                }
                
                Spacer()
            }
        }
    }
}

struct BioLoginView_Previews: PreviewProvider {
    static var previews: some View {
        BioLoginView()
    }
}
