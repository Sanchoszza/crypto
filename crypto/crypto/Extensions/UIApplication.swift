//
//  UIApplication.swift
//  crypto
//
//  Created by Alexandra on 07.06.2024.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
