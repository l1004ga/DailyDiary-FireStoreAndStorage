//
//  SignupView.swift
//  DailyDiary
//
//  Created by dev on 2023/01/10.
//

import SwiftUI
//지문 및 안면인식을 통해 잠금해제
import LocalAuthentication

struct SignupView: View {
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var passwordCheck: String = ""
    
    @EnvironmentObject var authVM : AuthVM
    
    //현재 인스턴스를 해제하기 위해 사용
    @Environment(\.dismiss) private var dismiss
    
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
    
    //지문 및 안면인식을 통해 잠금해제
    @State private var signupSuccess : Bool = false
    
    
    var body: some View {
        ZStack {
            Color("MainColor").ignoresSafeArea()
            
            ScrollView(showsIndicators: false){
                
                VStack{
                    Spacer()
                    HStack{
                        LottieView(jsonName: "126671-star-rating-good")
                            .frame(width: 50, height: 50)
                        
                        Text("회원가입")
                            .font(.custom("KyoboHandwriting2021sjy", size: 30))
                            .foregroundColor(.white)
                    }.padding(.leading, -150)
                    
                    
                    Spacer()
                    VStack{
                        Text("이름")
                            .padding(.leading, -150)
                            .font(.custom("KyoboHandwriting2021sjy", size: 25))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        TextField("이름",text: $name)
                            .modifier(TextFieldModifier())
                        
                        
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
                        
                        
                        Text("비밀번호 확인")
                            .padding(.leading, -150)
                            .font(.custom("KyoboHandwriting2021sjy", size: 25))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        SecureField("비밀번호 확인", text: $passwordCheck)
                            .modifier(TextFieldModifier())
                    }
                    
                    
                    Button {
                        Task{
                            await authVM.registerUser(email: email, password: password, name: name){ intValue, uidValue  in
                                switch intValue {
                                case 200: //회원가입 성공
                                    signupSuccess = true
                                case 17007:
                                    print("이미 가입한 계정")
                                    alertMessage = "이미 가입된 계정입니다."
                                    creatAlert = true
                                case 17008:
                                    print("맞지 않는 포맷")
                                    alertMessage = "이메일 형식이 올바르지 않습니다."
                                    creatAlert = true
                                case 17026:
                                    print("비밀번호를 6자리 이상 입력")
                                    alertMessage = "비밀번호를 6자리 이상 입력해주세요."
                                    creatAlert = true
                                default:
                                    print("오류")
                                }
                            }
                        }
                    } label: {
                        Text("회원가입 하기")
                            .foregroundColor(.yellow)
                            .font(.custom("KyoboHandwriting2021sjy", size: 25))
                            .fontWeight(.bold)
                    }
                    .fullScreenCover(isPresented: $signupSuccess) {
                        BioAuthView(email: email)
                    }
                    .padding(.top)
                    
                    Spacer()
                    
                    Button {
                        authVM.page = "Page1"
                    } label: {
                        Text("뒤로가기")
                            .foregroundColor(.white)
                            .font(.custom("KyoboHandwriting2021sjy", size: 20))
                    }
                    .padding(.top, 50)
                    
                }.padding(.top, 100)
            }
        }.onAppear(perform : UIApplication.shared.hideKeyboard)
            .alert(isPresented: self.$creatAlert,
                   content: { self.message(alertMessage: alertMessage) })
    }
}

struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(13)
            .background(.white)
            .cornerRadius(15)
            .autocapitalization(.none)
            .frame(width: 300)
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
