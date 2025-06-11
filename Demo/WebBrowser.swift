//
//  WebAPIs.swift
//  SwiftUI - IOS26Demo
//
//  Created by Trey Gaines on 6/11/25.
//
import SwiftUI
import WebKit

struct WebBrowser: View {
    @State private var webURL: String = ""
    @State private var showWebView = false
    @State private var showPinnedView = false
    @State var pins: [URL] = [URL(string: "https://www.apple.com")!, URL(string: "https://www.google.com")!, URL(string: "https://www.youtube.com")!, URL(string: "https://www.instagram.com")!]
    @State var pinnedURL: URL = URL(string: "https://www.apple.com")!
    
    
    var myUrl: URL {
        if let myUrl = URL(string: webURL),
           let scheme = myUrl.scheme,
           ["http", "https"].contains(scheme.lowercased()),
           let host = myUrl.host, !host.isEmpty {
            return myUrl
        } else { return URL(string: "https://www.apple.com")! }
    }
    
    var readyToGo: Bool {
        return !webURL.isEmpty
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("Background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(.rect(cornerRadius: 20))
                    .ignoresSafeArea()
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible())], spacing: 15) {
                        ForEach(pins, id: \.absoluteString) { pin in
                            Button {
                                pinnedURL = pin
                                showPinnedView = true
                            } label: {
                                Text(pin.absoluteString)
                                    .foregroundStyle(.white)
                                    .font(.title2)
                                    .fontWeight(.semibold)
                            }
                            .buttonStyle(.glass)
                        }
                    }.padding()
                }
            }
            .overlay {
                VStack {
                    Spacer()
                    HStack {
                        TextField("Enter URL", text: $webURL)
                            .padding()
                            .glassEffect(.regular, in: .capsule)
                            .frame(width: 300, height: 50)
                        Button {
                            showWebView = true
                        } label: {
                            if readyToGo {
                                Image(systemName: "magnifyingglass")
                                    .font(.title)
                                    .frame(width: 50, height: 40)
                            } else {
                                Image(systemName: "pencil")
                                    .font(.largeTitle)
                                    .transition(.opacity)
                                    .frame(width: 50, height: 40)
                            }
                        }
                        .disabled(!readyToGo)
                        .animation(.easeInOut(duration: 0.25), value: webURL)
                        .buttonStyle(.glass)
                    }
                }
                .padding()
            }
            .navigationTitle("Go to Page")
        }
        .preferredColorScheme(.dark)
        .sheet(isPresented: $showWebView) {
            WebSheet(pins: $pins, str: $webURL, myUrl: myUrl, title: myUrl.absoluteString)
        }
        .sheet(isPresented: $showPinnedView) {
            WebView(url: pinnedURL)
                .overlay {
                    VStack {
                        Button {
                            showPinnedView = false
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .glassEffect()
                                .foregroundStyle(.blue.gradient)
                                .font(.title)
                                .frame(width: 50, height: 50)
                        }
                        Spacer()
                    }
                    .padding(.all, 1)
                }
        }
    }
}

struct WebSheet: View {
    @Environment(\.dismiss) var dismiss
    @State private var isExpanded = false
    @Namespace private var animationA
    @Binding var pins: [URL]
    @Binding var str: String
    
    var myUrl: URL
    var title: String
    var body: some View {
        VStack {
            WebView(url: myUrl)
                .overlay {
                    GlassEffectContainer(spacing: 20) {
                        VStack(spacing: 20) {
                            Spacer()
                            if isExpanded {
                                Group {
                                    HStack(spacing: 20) {
                                        Button {
                                            pins.append(myUrl)
                                            str = ""
                                            dismiss()
                                        } label: {
                                            Image(systemName: "pin.fill")
                                                .frame(width: 50, height: 50)
                                                .font(.title)
                                        }
                                        
                                        Button {
                                            str = ""
                                            dismiss()
                                        } label: {
                                            Image(systemName: "xmark.circle.fill")
                                                .font(.title)
                                                .foregroundStyle(.red)
                                                .frame(width: 50, height: 50)
                                        }
                                            
                                    }
                                }
                                .glassEffect(.regular, in: .capsule)
                                .glassEffectUnion(id: "GroupA", namespace: animationA)
                            }
                            
                            Button {
                                withAnimation(.smooth(duration: 0.25, extraBounce: 0)) {
                                    isExpanded.toggle()
                                }
                            } label: {
                                Text(title)
                                    .padding(.all, 8)
                                    
                            }.buttonStyle(.glass)
                            
                        }
                    }
                    
                }
        }
    }
}


#Preview {
    WebBrowser()
}
