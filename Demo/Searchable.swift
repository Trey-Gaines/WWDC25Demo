//
//  Searchable.swift
//  SwiftUI - IOS26Demo
//
//  Created by Trey Gaines on 7/23/25.
//

import SwiftUI
import FoundationModels

struct Search: View {
    @State var myParks: [Park] = []
    @State var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    if myParks.count > 0 {
                        ForEach(myParks, id:  \.self.parkName) { park in
                            Text("\(park.parkName)")
                        }
                    }
                }.searchable(text: $searchText)
                
                if myParks.count <= 0 {
                    ProgressView("Generating")
                }
            }
        }.onAppear {
            myParks = generateItems()
        }
    }
    
    
    func generateItems() -> [Park] {
        let bot = LanguageModelSession()
        let count = Int.random(in: 2...3)
        
        var items = [Park]()
        
        for i in 1..<count {
            Task {
                do {
                    let ans = try await bot.respond(to: "Generate a Park item with a parkName and parkLocation", generating: Park.self).content
                    items.append(ans)
                    print("Generated \(i)")
                } catch { print(error) }
            }
        }; return items
    }
}



@Generable
struct Park: Hashable {
    @Guide(description: "The name of the park")
    var parkName: String
    @Guide(description: "The location of the park")
    var parkLocation: String
}


#Preview {
    Search()
}
