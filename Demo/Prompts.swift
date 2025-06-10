//
//  Item.swift
//  Demo
//
//  Created by Trey Gaines on 6/10/25.
//

import SwiftUI
import FoundationModels


struct Prompts: View {
    @State private var prompt = ""
    @State private var answer = ""
    @State private var disable = false
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView(.vertical) {
                    Text(answer)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .multilineTextAlignment(.leading)
                        .padding(20)
                        .foregroundStyle(.white)
                    
                }.safeAreaBar(edge: .bottom) {
                    HStack(spacing: 25) {
                        TextField("Prompt", text: $prompt)
                            .padding(15)
                            .glassEffect(.regular, in: .capsule)
                        
                        Button {
                            Task { guard prompt != "" else { return }
                                do {
                                    let bot = LanguageModelSession()
                                    disable = true
                                    
                                    let ans = bot.streamResponse(to: prompt)
                                    prompt.removeAll()
                                    for try await chunk in ans { answer = chunk }
                                    disable = false
                                } catch {
                                    disable = false
                                    print(error.localizedDescription)
                                }
                            }
                        } label: {
                            VStack {
                                    if prompt != "" {
                                        Image(systemName: "paperplane.fill")
                                            .font(.largeTitle)
                                            .transition(.opacity)
                                            .frame(width: 50, height: 39)
                                    } else {
                                        Image(systemName: "pencil")
                                            .font(.largeTitle)
                                            .transition(.opacity)
                                            .frame(width: 50, height: 39)
                                    }
                            }.animation(.easeInOut(duration: 0.25), value: prompt)
                        }
                        .buttonStyle(.glass)
                        .disabled(disable)
                    }
                    .padding()
                }
            } .preferredColorScheme(.dark)
                .navigationTitle("My Bot")
        }
    }
}


#Preview {
    Prompts()
}
