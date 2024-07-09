//
//  XMarkButton.swift
//  crypto
//
//  Created by Alexandra on 10.06.2024.
//

import SwiftUI

struct XMarkButton: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        },
           label: {
                Image(systemName: "xmark")
                    .font(.headline)
            })
    }
}

#Preview {
    XMarkButton()
}
