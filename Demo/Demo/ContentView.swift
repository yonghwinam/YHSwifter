//
//  ContentView.swift
//  Demo
//
//  Created by Yonghwi on 8/2/24.
//

import SwiftUI
import YHSwifter

struct ContentView: View {
    let swifter = YHSwifter()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .task {
            YHDebugLog("status bar height: \(swifter.statusBarHeight())")
        }
    }
}

#Preview {
    ContentView()
}
