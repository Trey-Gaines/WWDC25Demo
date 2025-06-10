//
//  Home.swift
//  Demo
//
//  Created by Trey Gaines on 6/10/25.
//

import SwiftUI
struct Home: View {
    @State private var isExpanded = false
    @Namespace private var animationA
    var body: some View {
        ZStack {
            Image("Background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipShape(.rect(cornerRadius: 20))
                .ignoresSafeArea()
                .overlay {
                    GlassEffectContainer(spacing: 20) {
                        VStack(spacing: 20) {
                            Spacer()
                            
                            if isExpanded {
                                Group {
                                    Image(systemName: "suit.heart.fill")
                                        .foregroundStyle(.red.gradient)
                                        .frame(width: 50, height: 50)
                                        .font(.title)
                                    Image(systemName: "magnifyingglass")
                                        .foregroundStyle(.white.gradient)
                                        .font(.title)
                                        .frame(width: 50, height: 50)
                                        
                                }
                                .glassEffect(.regular, in: .buttonBorder)
                                .glassEffectUnion(id: "GroupA", namespace: animationA)
                                //.glassEffectTransition(.identity) will reduce animations
                                
                            }
                            
                            Button {
                                withAnimation(.smooth(duration: 1, extraBounce: 0)) {
                                    isExpanded.toggle()
                                }
                            } label: {
                                Image(systemName: "ellipsis")
                                    .font(.title)
                                    .foregroundStyle(.white.gradient)
                                    .frame(width: 30, height: 30)
                            }.buttonStyle(.glass)
                        }
                    }
                }
            
//            Image(systemName: "suit.heart.fill")
//                .font(.largeTitle)
//                .foregroundStyle(.red.gradient)
//                .frame(width: 50, height: 50)
//                .glassEffect(.regular.interactive(), in: .buttonBorder)
//        .glassEffect(.regular.tint(.red.opacity(0.35)).interactive(), in: .capsule)
            
            
            
            
            
        }
    }
}


#Preview { Home() }
