//  Scraper.swift
//  SwiftUI - IOS26Demo
//
//  Created by Trey Gaines on 6/12/25.
//

import SwiftUI
import WebKit
import SwiftData

struct Scraper: View {
    let url = URL(string: "https://www.simplyrecipes.com/recipes/blueberry_cake/")!
    @State private var htmlContent: String = ""
    @State private var showHTMLSheet = false

    var body: some View {
//        VStack {
//            WebPreview(url: url, htmlContent: $htmlContent)
//                .edgesIgnoringSafeArea(.all)
//
//            Button("View Scraped HTML") {
//                showHTMLSheet = true
//            }
//            .padding()
//            .sheet(isPresented: $showHTMLSheet) {
//                HTMLViewer(htmlContent: htmlContent)
//            }
//        }
    }
}

#Preview {
    Scraper()
}

