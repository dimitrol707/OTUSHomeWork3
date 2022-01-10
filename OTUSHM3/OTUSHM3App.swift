//
//  OTUSHM3App.swift
//  OTUSHM3
//
//  Created by Дмитрий Мальцев on 28.12.2021.
//

import SwiftUI

@main
struct OTUSHM3App: App {
    
    init() {
        Configurator.shared.register()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
