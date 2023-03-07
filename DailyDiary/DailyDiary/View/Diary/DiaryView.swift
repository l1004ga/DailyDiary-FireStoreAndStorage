//
//  DiaryView.swift
//  DailyDiary
//
//  Created by dev on 2023/01/11.
//

import SwiftUI

struct DiaryView: View {
    
    @EnvironmentObject var diaryVM : DiaryVM
    @EnvironmentObject var authVM : AuthVM
    
    
    @State private var showingAddingSheet: Bool = false
    @State var category : String
    
    var body: some View {
        NavigationView{
            ZStack{
                Color("MainColor").ignoresSafeArea()
                
                
                VStack {
                    
                    Color("MainColor").ignoresSafeArea()
                    
                    Color("MainColor").ignoresSafeArea()
                    
                    Text("나의 \(category) 일기")
                        .font(.custom("KyoboHandwriting2021sjy", size: 30))
                        .foregroundColor(.white)
                        .padding(.top, 800)
                    
                    
                    List(diaryVM.diarys.filter{ $0.category == category }) { diary in
                        NavigationLink(destination: {
                            DairyDetailView(diary: diary)
                        }) {
                            
                            VStack(alignment: .leading) {
                                Text(diary.createdDate)
                                    .font(.custom("KyoboHandwriting2021sjy", size: 25))
                                    .padding()
                                Text(diary.memo)
                                    .padding()
                                    .font(.custom("KyoboHandwriting2021sjy", size: 20))
                            }.background(Color("MainColor"))
                                .padding()
                                .foregroundColor(.white)
                        }.listRowBackground(Color("MainColor"))
                    }.listStyle(.plain)
                        .frame(height: 800)
                    //                    .navigationDestination(for: Diary.self, destination: { diary in
                    //                        PostitDetailView(postitStore: postitStore, postit: postit)
                    //                    })
                    
                    
                    
                    if diaryVM.diarys.isEmpty {
                        Text("It's empty!")
                            .padding()
                    }
                    
                }.offset(y : -330)
                    .background(Color("MainColor"))
                    .onAppear {
                        diaryVM.fetchPostits(email: authVM.storeEmail!)
                    }
                    .refreshable {
                        diaryVM.fetchPostits(email: authVM.storeEmail!)
                    }
                
                Button {
                    showingAddingSheet = true
                } label: {
                    Image(systemName: "plus.circle").resizable().frame(width: 50, height: 50).foregroundColor(.white)
                }.offset(x: 130, y: 320)
                    .fullScreenCover(isPresented: $showingAddingSheet) {
                        DiaryAddView(category: category, showingSheet: $showingAddingSheet)
                    }
                
            }.background(Color("MainColor"))
        }
    }
}

struct DiaryView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryView(category: "행복")
            .environmentObject(AuthVM())
            .environmentObject(DiaryVM())
    }
}
