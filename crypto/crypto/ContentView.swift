//
//  ContentView.swift
//  crypto
//
//  Created by Alexandra on 06.06.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            
            VStack {
                Text("COLOR ONE")
                Text("COLOR TWO")
            }
        }
    }
}

#Preview {
    ContentView()
}
