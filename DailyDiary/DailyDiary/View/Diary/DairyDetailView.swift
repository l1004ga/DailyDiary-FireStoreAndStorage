//
//  DairyDetailView.swift
//  DailyDiary
//
//  Created by dev on 2023/03/07.
//

import SwiftUI

struct DairyDetailView: View {
    
    @EnvironmentObject var authVM : AuthVM
    var diary : Diary
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack{
                    HStack{
                        Text("\(diary.createdDate)")
                            .foregroundColor(.yellow)
                            .font(.custom("KyoboHandwriting2021sjy", size: 25))
                        Spacer()
                        //                        Text("지나의 \(diary.category)일기")
                        //                            .foregroundColor(.yellow)
                        //                            .font(.custom("KyoboHandwriting2021sjy", size: 25))
                        Text("\(authVM.storeName!)의 \(diary.category)일기")
                            .foregroundColor(.yellow)
                            .font(.custom("KyoboHandwriting2021sjy", size: 25))
                        
                    }.padding()
                    
                    VStack (alignment: .leading){
                        ScrollView(.horizontal) {
                            HStack {
                                //이미지 보여줌
                                
                                ForEach(diary.images, id: \.self) { diaryImage in
                                    AsyncImage(url: URL(string: diaryImage)){ image in
                                        image
                                            .resizable()
                                            .frame(width: 128, height: 128)
                                    } placeholder: {
                                        Image("ready_image")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 128, height: 128)
                                            .cornerRadius(12)
                                    }
                                }
                            }
                        }
                        
                        ScrollView{
                            Text("\(diary.memo)")
                                .accentColor(.yellow)
                                .foregroundColor(.white)
                                .font(.custom("KyoboHandwriting2021sjy", size: 20))
                                .padding(.top, 30)
                            
                        }
                        
                        
                    }
                    .padding(15)
                    .background(Color("MainColor"))
                    
                    
                    
                    //            Button {
                    //                dismiss()
                    //            } label: {
                    //                Text("뒤로가기")
                    //                    .foregroundColor(.white)
                    //                    .font(.custom("KyoboHandwriting2021sjy", size: 20))
                    //            }.offset(y:370)
                }
            }.background(Color("MainColor"))
        }
    }
}
struct DairyDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DairyDetailView(diary: Diary(id: "test", username: "지나", memo: "일기 내용", createdAt: Date(), images: ["https://firebasestorage.googleapis.com/v0/b/dailydiary-a62b2.appspot.com/o/0B59B9C3-DAF8-432B-8753-08895B5EB391?alt=media&token=826d014e-253c-4edf-8642-c9222aab9126", "https://firebasestorage.googleapis.com/v0/b/dailydiary-a62b2.appspot.com/o/0B59B9C3-DAF8-432B-8753-08895B5EB391?alt=media&token=826d014e-253c-4edf-8642-c9222aab9126"], category: "슬픔"))
    }
}
