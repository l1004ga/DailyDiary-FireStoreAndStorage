//
//  MyPageView.swift
//  DailyDiary
//
//  Created by dev on 2023/01/11.
//

import SwiftUI

struct MyPageView: View {
    
    @EnvironmentObject var authVM : AuthVM
    
    var myPageList: [String] = [
        "나의하루 소개",
        "버전 정보"]
    
    var myPageListWebLink: [String] = [
        "https://hot-pineapple-a35.notion.site/4dc719cb8dc643949325ae53087902fb", //앱 소개
        "https://hot-pineapple-a35.notion.site/9cdb960b830a4aee8beda42bb7557e2f" // 버전정보 링크
    ]
    
    @State var selectedUrl: URL = URL(string: "https://hot-pineapple-a35.notion.site/cc463a73a1b74bcdbd1c77622244a401")!
    
    @State private var isShowingSheet: Bool = false
    
    var body: some View {
        NavigationView{
            ZStack(alignment: .leading){
                Color("MainColor").ignoresSafeArea()
                VStack{
                    HStack{
                        Group{
                            Text("지나").foregroundColor(Color.accentColor).font(.custom("KyoboHandwriting2021sjy", size: 30)) + Text(" 님의 마이페이지").foregroundColor(.white).font(.custom("KyoboHandwriting2021sjy", size: 25))
                            //                            Text("\(authVM.storeName!)").foregroundColor(Color.accentColor).font(.system(size: 25)) + Text(" 님의 마이페이지").foregroundColor(.white).font(.system(size: 20))
                        }.foregroundColor(.white)  //\(authVM.storeName!)
                        Spacer()
                        Button {
                            authVM.logout()
                            authVM.page = "Page1"
                        } label: {
                            Text("로그아웃").foregroundColor(Color.accentColor).font(.custom("KyoboHandwriting2021sjy", size: 18))
                        }.padding(.trailing, 10)
                        
                    }.padding()
                    
                    Divider().overlay(Color.white)
                    
                    List {
                        ForEach(0..<myPageList.count, id: \.self) { index in
                            
                            Button(action: {
                                // 버튼 액션에서 selectedUrl에 지금 누른 버튼 링크 값을 넣어줌
                                selectedUrl = URL(string: myPageListWebLink[index])!
                                isShowingSheet.toggle()
                                
                            }){
                                Text("\(myPageList[index])") // 리스트 이름
                                    .font(.custom("KyoboHandwriting2021sjy", size: 22))
                                    .background(Color("MainColor"))
                                    .foregroundColor(.white)
                                
                            }
                            .sheet(isPresented: $isShowingSheet, content: {
                                SafariWebView(selectedUrl: $selectedUrl)
                            })
                            .listRowSeparator(.hidden)
                        }.listRowBackground(Color("MainColor"))
                    }
                    .listStyle(.plain)
                    .scrollDisabled(true)
                    
                }.padding(.leading, 10)
            }
        }
    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView()
    }
}
