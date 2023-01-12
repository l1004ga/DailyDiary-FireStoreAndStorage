//
//  MainView.swift
//  DailyDiary
//
//  Created by dev on 2023/01/10.
//

import SwiftUI

struct MainView: View {
    
    @State private var lottieName : String = ""
    
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color("MainColor").ignoresSafeArea()
                
                VStack {
                    
                    Text("별들에게 이야기해보는 나의 하루")
                        .font(.custom("KyoboHandwriting2021sjy", size: 25))
                        .foregroundColor(.white)
                    
                    Group{
                        
                        NavigationLink(destination: DiaryView(category: "행복")) {
                            LottieView(jsonName: "126671-star-rating-good")
                                .frame(width: 60, height: 60)
                        }.offset(x: 100, y: 20)
                            .padding(.top)
                        
                        
                        NavigationLink(destination: DiaryView(category: "슬픔")) {
                            LottieView(jsonName: "126670-star-rating-bad")
                                .frame(width: 60, height: 60)
                        }.offset(x: -120)
                        
                        
                        NavigationLink(destination: DiaryView(category: "사랑")) {
                            LottieView(jsonName: "126668-star-rating-awesome")
                                .frame(width: 60, height: 60)
                        }.offset(x: -10, y: 20)
                        
                        
                        NavigationLink(destination: DiaryView(category: "우울")) {
                            LottieView(jsonName: "126667-star-rating-horrible")
                                .frame(width: 60, height: 60)
                        }.offset(x: 130, y: 0)
                        
                        NavigationLink(destination: DiaryView(category: "기쁨")) {
                            LottieView(jsonName: "126666-star-rating-okay")
                                .frame(width: 60, height: 60)
                        }.offset(x: -130, y: 10)
                        
                        NavigationLink(destination: MyPageView()) {
                            VStack{
                                LottieView(jsonName: "89033-star-in-hand-baby-astronaut")
                                    .frame(width: 200, height: 200)
                                Text("나의 페이지")
                                    .font(.custom("KyoboHandwriting2021sjy", size: 22))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(.top, -15)
                            }
                        }.offset(x: 120, y: 70)
                        
                    }
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
