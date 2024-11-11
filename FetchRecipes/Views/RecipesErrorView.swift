//
//  RecipesErrorView.swift
//  FetchRecipes
//
//  Created by Bianca Curutan on 11/7/24.
//

import SwiftUI

struct RecipesErrorView: View {

    var retryAction: () -> Void

    var body: some View {
        Text("Error loading recipes")
            .font(.headline)
            .foregroundColor(.red)
        Text("Tap to try again.")
            .font(.subheadline)
            .foregroundColor(.red)
            .padding(.bottom, 16)
        Button(action: retryAction) {
            Image(systemName: "arrow.clockwise")
                .foregroundStyle(Color.accent)
                .imageScale(.large)
        }
    }
}

#Preview {
    RecipesErrorView(retryAction: {})
}
