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




struct WebPreview: UIViewRepresentable {
    func updateUIView(_ uiView: WKWebView, context: Context) {
        //Needed for comformance to UIViewRepresentable
    }

    let url: URL
    @Binding var htmlContent: String

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        webView.load(URLRequest(url: url))
        return webView
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebPreview

        init(_ parent: WebPreview) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                webView.evaluateJavaScript("document.documentElement.outerHTML.toString()") { result, error in
                    if let html = result as? String {
                        DispatchQueue.main.async {
                            self.parent.htmlContent = html
                        }
                    } else if let error = error {
                        print("Error scraping HTML: \(error.localizedDescription)")
                    }
                }
            }
        }

    }
}


struct HTMLViewer: UIViewRepresentable {
    let htmlContent: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.loadHTMLString(htmlContent, baseURL: nil)
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(htmlContent, baseURL: nil)
    }
}


