//
//  ElementView.swift
//  
//
//  Created by Дмитрий Мальцев on 12.01.2022.
//

import SwiftUI

public struct ElementView: View {
    public var text: String
    
    public init(text: String) {
        self.text = text
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            Text(text)
                .font(.headline)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity, minHeight: 50)
        .padding(.vertical, 5)
        .padding(.horizontal, 10)
        .background(
            Color.white
        )
        .cornerRadius(10)
    }
}
