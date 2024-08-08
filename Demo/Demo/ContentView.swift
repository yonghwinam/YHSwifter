//
//  ContentView.swift
//  Demo
//
//  Created by Yonghwi on 8/2/24.
//

import SwiftUI
import YHSwifter

struct ContentView: View {
    var body: some View {
        let urlString = "https://pbs.twimg.com/media/GULdqNcWkAADIOI?format=jpg&name=900x900"
    
        YHAsyncImage(urlString, radious: 10) {
            Color.yellow
        }
        
        YHImage("img2", 200, 200, .fit, radious: 9) {
            Color.yellow
        }
    }
}

#Preview {
    let urlString = "https://pbs.twimg.com/media/GULdqNcWkAADIOI?format=jpg&name=900x900"
    let uiImage = UIImage(named: "img1.jpg")
    ContentView()
}
