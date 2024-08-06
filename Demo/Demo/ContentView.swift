//
//  ContentView.swift
//  Demo
//
//  Created by Yonghwi on 8/2/24.
//

import SwiftUI
import YHSwifter

struct User: Codable {
    var name: String?
    var age: Int?
}

struct ContentView: View {
    let swifter = YHSwifter()
    
    var body: some View {
        VStack {
            Text("Hello Swifter!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
