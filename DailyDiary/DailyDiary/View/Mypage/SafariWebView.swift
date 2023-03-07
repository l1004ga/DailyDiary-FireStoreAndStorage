//
//  SafariWebView.swift
//  DailyDiary
//
//  Created by dev on 2023/03/07.
//

import SwiftUI
import SafariServices

struct SafariWebView: UIViewControllerRepresentable {
    @Binding var selectedUrl: URL
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariWebView>) -> SFSafariViewController {
        return SFSafariViewController(url: selectedUrl)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        
    }
}
