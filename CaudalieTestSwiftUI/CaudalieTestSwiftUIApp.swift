//
//  CaudalieTestSwiftUIApp.swift
//  CaudalieTestSwiftUI
//
//  Created by Sébastien Rochelet on 05/06/2023.
//

import SwiftUI

@main
struct CaudalieTestSwiftUIApp: App {
    @StateObject private var mediaListviewModel = MediaListViewModel()
    
    var body: some Scene {
        WindowGroup {
            MediaListView()
                .environmentObject(mediaListviewModel)
        }
    }
}
