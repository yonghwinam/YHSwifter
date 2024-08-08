//
//  DetailImage.swift
//  Demo
//
//  Created by Yonghwi on 8/8/24.
//

import SwiftUI
import YHSwifter

struct DetailImage: View {
    var body: some View {
        YHImage("img1", 250, 250, .fit, radious: 15, opacity: 0.9) {
            Color.black
        }
    }
}

#Preview {
    DetailImage()
        .navigationTitle("YHImage")
}
