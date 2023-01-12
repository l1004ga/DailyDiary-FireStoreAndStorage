//
//  LoginView.swift
//  DailyDiary
//
//  Created by dev on 2023/01/10.
//

import SwiftUI
//지문 및 안면인식을 통해 잠금해제
import LocalAuthentication

struct LoginView: View {
    @State private var isUnlocked : Bool = false
    @State private var email: String = ""
    @State private var password: String = ""
    
    @EnvironmentObject var authVM : AuthVM
    
    //회원가입 버튼 누를 시 회원가입 뷰 전환에 사용되는 변수
    @State private var stillLogin : Bool = false
    
    //생체인식 실행 함수
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        // check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // it's possible, so go ahead and use it
            let reason = "We need to unlock your data."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                // authentication has now completed
                if success {
                    isUnlocked = true
                    print("성공")
                } else {
                    print("실패")
                    // there was a problem
                }
            }
        } else {
            // no biometrics
        }
    }
    
    //회원가입 실패 시 알림창을 보여주는데 사용되는 변수
    @State var creatAlert : Bool = false
    @State var alertMessage : String = ""
    
    //알림창의 contents를 만들어주기 위한 함수
    func message(alertMessage : String) -> Alert {
        Alert(
            title: Text("실패"),
            message: Text("\(alertMessage)"),
            dismissButton: .default(Text("닫기")))

    }
    
    var body: some View {
        ZStack {
            Color("MainColor").ignoresSafeArea()
            
            VStack{
                Spacer()
                LottieView(jsonName: "126671-star-rating-good")
                    .frame(width: 150, height: 150)
                
                Group{
                    Text("소중한 ") + Text("나의 하루").fontWeight(.bold).foregroundColor(.yellow) + Text("를 기록해보세요")
                }
                .font(.custom("KyoboHandwriting2021sjy", size: 30))
                .foregroundColor(.white)
                .padding(.top)
                
                
                Spacer()
                Group{
                    Text("이메일")
                        .padding(.leading, -150)
                        .font(.custom("KyoboHandwriting2021sjy", size: 25))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    TextField("이메일",text: $email)
                        .modifier(TextFieldModifier())
                    
                    Text("비밀번호")
                        .padding(.leading, -150)
                        .font(.custom("KyoboHandwriting2021sjy", size: 25))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    SecureField("비밀번호", text: $password)
                        .modifier(TextFieldModifier())
                }
                Group{
                    Button {
                        Task{
                            authVM.storeEmail = email
                            
                            await authVM.loginUser(email: email, password: password){ codeValue in
                                switch codeValue {
                                case 200:
                                    authVM.page = "Page2"
                                case 17008:
                                    alertMessage = "이메일 형식이 아닙니다."
                                    creatAlert = true
                                case 17009:
                                    alertMessage = "비밀번호가 다릅니다."
                                    creatAlert = true
                                default:
                                    alertMessage = "이메일과 비밀번호가 올바른지 확인해주세요."
                                    creatAlert = true
                                }
                            }
                            hideKeyboard()
                        }
                    } label: {
                        Text("로그인 하기")
                            .foregroundColor(.yellow)
                            .font(.custom("KyoboHandwriting2021sjy", size: 25))
                            .fontWeight(.bold)
                    }
                    .padding(.top, 30)
                    
                    Spacer()
                    Spacer()
                    
                    Button {
                        authVM.page = "Page3"
                    } label: {
                        Text("회원가입")
                            .foregroundColor(.white)
                            .font(.custom("KyoboHandwriting2021sjy", size: 20))
                    }
                    .padding(.top)
//                    .fullScreenCover(isPresented: $signUpIsPresented) {
//                        authVM.page = "Page3"
//                    }
                    Spacer()
                    
                }
                
//                if isUnlocked {
//                    // TODO: 페이지 전환
//                } else {
//                    // TODO: 오류 메세지 전달
//                }
            }.onAppear(perform : UIApplication.shared.hideKeyboard)
                .alert(isPresented: self.$creatAlert,
                       content: { self.message(alertMessage: alertMessage) })
        }
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
