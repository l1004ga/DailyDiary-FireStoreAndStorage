//
//  ContentView.swift
//  DailyDiary
//
//  Created by dev on 2023/01/10.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authVM : AuthVM
    
    @State private var bioAuth = UserDefaults.standard.bool(forKey: "bioAuthOnOff")
    
    var body: some View {
        VStack {
            //생체 로그인 등록 안 한 사람
            if bioAuth == false {
                if authVM.page == "Page1" {
                    LoginView()
                } else if authVM.page == "Page2" {
                    MainView()
                } else if authVM.page == "Page3" {
                    SignupView()
                } else {
                    LoginView()
                }
            } else if bioAuth == true {
                if let _ = authVM.currentUser {
                    if authVM.page == "Page1" {
                        BioLoginView()
                    } else if authVM.page == "Page2" {
                        MainView()
                    } else if authVM.page == "Page3" {
                        SignupView()
                    } else {
                        LoginView()
                    }
                } else {
                    if authVM.page == "Page1" {
                        LoginView()
                    } else if authVM.page == "Page2" {
                        MainView()
                    } else if authVM.page == "Page3" {
                        SignupView()
                    } else {
                        LoginView()
                    }
                }
            }
            
            
            //            if let _ = authVM.currentUser {
            //                MainView()
            //            } else {
            //                if authVM.page == "Page1" {
            //                    LoginView()
            //                } else if authVM.page == "Page3"  {
            //                    SignupView()
            //                } else {
            //                    LoginView()
            //                }
            //            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(AuthVM())
    }
}
