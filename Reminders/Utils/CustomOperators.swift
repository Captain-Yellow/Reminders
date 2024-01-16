//
//  CustomOperators.swift
//  Reminders
//
//  Created by Mohammad Afshar on 12/01/2024.
//

import Foundation
import SwiftUI

public func ??<T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
    Binding {
        lhs.wrappedValue ?? rhs
    } set: { value in
        lhs.wrappedValue = value
    }
}
