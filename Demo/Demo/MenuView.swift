//
//  MenuView.swift
//  Demo
//
//  Created by Yonghwi on 8/8/24.
//

import SwiftUI
import YHSwifter

struct MenuItem: Identifiable, Hashable {
    let id = UUID()
    let name: String
}

let menuItems = [
    MenuItem(name: "YHImage"),
    MenuItem(name: "YHAsyncImage")
]

struct MenuView: View {
    @State var navigationPaths = NavigationPath()
    var body: some View {
        NavigationStack(path: $navigationPaths) {
            List(menuItems) { menuItem in
                NavigationLink(menuItem.name, value: menuItem)
                
            }
            .navigationTitle("YHSwifter Demo")
            .navigationDestination(for: MenuItem.self) { menuItem in
                DetailImage()
                    .navigationTitle(menuItem.name)
            }
        }
    }
}

#Preview {
    MenuView()
}
