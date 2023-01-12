//
//  BioAuthView.swift
//  DailyDiary
//
//  Created by dev on 2023/01/10.
//

import SwiftUI
//지문 및 안면인식을 통해 잠금해제
import LocalAuthentication

struct BioAuthView: View {
    @State private var isUnlocked : Bool = false
    @State private var upPassword : Bool = false
    
    var email: String
    @State private var password: String = ""
    
    @EnvironmentObject var authVM : AuthVM
    
    //현재 인스턴스를 해제하기 위해 사용
    @Environment(\.dismiss) private var dismiss
    
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
                    upPassword = true
                    
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
    
    //생체인식 성공여부
    @State var bioCheck : Bool = false
    
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
                
                Text("Face ID 인증사용")
                    .font(.custom("KyoboHandwriting2021sjy", size: 30))
                    .foregroundColor(.yellow)
                    .padding(.bottom, 20)
                
                Group{
                    Text("스마트폰에 등록된 생체인증을")
                    Text("사용하여 인증하시겠습니까?")
                }
                .font(.custom("KyoboHandwriting2021sjy", size: 20))
                .foregroundColor(.white)
                .frame(alignment: .center)
                
                Button {
                    //생체인증 함수 실행
                    authenticate()
                } label: {
                   bioCheck ? Text("인증완료")
                        .padding()
                        .frame(width: 300)
                        .background(.yellow)
                        .cornerRadius(15)
                        .foregroundColor(Color(.red)) : Text("인증하기").padding()
                        .frame(width: 300)
                        .background(.yellow)
                        .cornerRadius(15)
                        .foregroundColor(Color("MainColor"))
                }
                .disabled(bioCheck)
                .padding(.top, 30)
                .sheet(isPresented: $upPassword) {
                    VStack{
                        Text("인증을 위해 비밀번호를 입력해주세요")
                            .padding(.top)
                            .font(.custom("KyoboHandwriting2021sjy", size: 22))
                            .fontWeight(.bold)
                            .foregroundColor(Color("MainColor"))

                        Text("비밀번호")
                            .padding(.leading, -150)
                            .padding(.top)
                            .font(.custom("KyoboHandwriting2021sjy", size: 25))
                            .fontWeight(.bold)
                            .foregroundColor(Color("MainColor"))

                        SecureField("비밀번호", text: $password)
                            .modifier(TextFieldModifier())
                            .overlay(RoundedRectangle(cornerRadius: 15)
                                .stroke(Color("MainColor"), lineWidth: 2)
                            )

                        Button {
                            Task{
                                await authVM.loginUser(email: email, password: password){ codeValue in
                                    switch codeValue {
                                    case 200:
                                        bioCheck = true
                                        upPassword = false
                                    default:
                                        alertMessage = "비밀번호가 올바른지 확인해주세요."
                                        creatAlert = true
                                    }
                                }
                                hideKeyboard()
                            }
                        } label: {
                            Text("확인")
                                .padding()
                                .foregroundColor(Color("MainColor"))
                        }



                    }.presentationDetents([.fraction(0.3)])
                        .presentationDragIndicator(.hidden)
                }
                
                Button {
                        authVM.page = "Page1"
                } label: {
                    Text("로그인 하러가기")
                        .foregroundColor(.white)
                        .font(.custom("KyoboHandwriting2021sjy", size: 20))
                }
                .padding(.top, 50)
                
                Spacer()
                Spacer()
                
                
            }
            
        }
        
    }
}

struct BioAuthView_Previews: PreviewProvider {
    static var previews: some View {
        BioAuthView(email : "test@email.com")
    }
}
