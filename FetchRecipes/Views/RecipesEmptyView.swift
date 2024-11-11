//
//  RecipesEmptyView.swift
//  FetchRecipes
//
//  Created by Bianca Curutan on 11/7/24.
//

import SwiftUI

struct RecipesEmptyView: View {

    var refreshAction: () -> Void

    var body: some View {
        Text("No recipes available")
            .font(.headline)
            .foregroundColor(.secondary)
        Text("Tap to refresh.")
            .font(.subheadline)
            .foregroundColor(.secondary)
            .padding(.bottom, 16)
        Button(action: refreshAction) {
            Image(systemName: "arrow.clockwise")
                .foregroundStyle(Color.accent)
                .imageScale(.large)
        }
    }
}

#Preview {
    RecipesEmptyView(refreshAction: {})
}
