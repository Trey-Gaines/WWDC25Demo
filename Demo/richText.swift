//
//  richText.swift
//  SwiftUI - IOS26Demo
//
//  Created by Trey Gaines on 7/23/25.
//

import SwiftUI
struct MyTextEditor: View {
    @State var navTitle: AttributedString = "Note Title"
    @State var bodyString: AttributedString = "Note Body"
    @State var clicked: Bool = false
    
    @State var attributedSelection = AttributedTextSelection()
    
    var body: some View {
        NavigationStack {
            TextEditor(text: $navTitle, selection: $attributedSelection)
                .padding(.horizontal, 30)
                .padding(.vertical, 10)
                .lineLimit(1)
                .frame(height: 70)
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(1)
                .font(.title)
                .scrollContentBackground(.hidden)
                .fontWeight(.semibold)
                .background {
                    RoundedRectangle(cornerRadius: 25).fill(Color(UIColor.systemGray3))
                        .opacity(0.35)
                }
                
                
            VStack {
                TextEditor(text: $bodyString, selection: $attributedSelection)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .frame(minWidth: 380, minHeight: 300)
                    .scrollContentBackground(.hidden)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .background {
                        RoundedRectangle(cornerRadius: 25).fill(Color(UIColor.systemGray2))
                            .opacity(0.25)
                    }
                Button(role: .destructive) {
                    navTitle = "Note Title"
                    bodyString = "Note Body"
                    
                } label: {
                    VStack {
                        Image(systemName: "trash")
                            .foregroundStyle(.white)
                            .padding()
                            .symbolEffect(.drawOff, isActive: clicked)
                            .background {
                                RoundedRectangle(cornerRadius: 25).fill(Color.red)
                            }
                        Text("Restart Note")
                    }
                }
            }
            
            Spacer()
                .navigationTitle("New Note")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    MyTextEditor()
        .preferredColorScheme(.dark)
}
