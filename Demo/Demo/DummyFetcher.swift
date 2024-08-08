//
//  DummyFetcher.swift
//  Demo
//
//  Created by Yonghwi on 8/8/24.
//

import SwiftUI
import YHSwifter

class DummyFetcher: ObservableObject {
    @Published var images = [DummyImage]()
    
    func fetchImages() async {
        let response = await YH.requestGET("https://picsum.photos/v2/list", decoder: [DummyImage].self)
        YHResponseLog(response)
        guard let images = response.decodedResult else { return }
        
        Task { @MainActor in
            self.images = images
        }
        
    }
}
