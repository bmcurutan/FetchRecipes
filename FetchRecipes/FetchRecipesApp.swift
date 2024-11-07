//
//  FetchRecipesApp.swift
//  FetchRecipes
//
//  Created by Bianca Curutan on 11/5/24.
//

import SwiftUI

@main
struct FetchRecipesApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                RecipesListView()
                    .navigationBarTitleDisplayMode(.inline) 
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            HStack {
                                Image("fetch-logo")
                                    .resizable()
                                    .frame(width: 32, height: 32)
                                Text("Fetch Recipes")
                                    .font(.headline)
                            }
                        }
                    }
            }
        }
    }
}
