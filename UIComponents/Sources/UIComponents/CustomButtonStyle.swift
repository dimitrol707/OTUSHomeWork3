//
//  CustomButtonStyle.swift
//  
//
//  Created by Дмитрий Мальцев on 12.01.2022.
//

import SwiftUI

public struct CustomButtonStyle: ButtonStyle {
    public init() { }
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding()
            .background(
                Capsule()
                    .foregroundColor(.blue)
            )
    }
}

