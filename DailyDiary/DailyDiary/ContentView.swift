//
//  ContentView.swift
//  DailyDiary
//
//  Created by dev on 2023/01/10.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authVM : AuthVM
    
    var body: some View {
        VStack {
            if authVM.page == "Page1" {
                LoginView()
            } else if authVM.page == "Page2" {
                MainView()
            } else if authVM.page == "Page3"  {
                SignupView()
            } else {
                LoginView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(AuthVM())
    }
}
