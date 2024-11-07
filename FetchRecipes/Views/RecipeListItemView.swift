//
//  RecipeListItemView.swift
//  FetchRecipes
//
//  Created by Bianca Curutan on 11/5/24.
//

import Kingfisher
import SwiftUI

struct RecipeListItemView: View {

    @ObservedObject var viewModel: RecipesViewModel

    let recipe: Recipe

    @State private var isSourceWebViewPresented = false
    @State private var isYoutubeWebViewPresented = false

    var body: some View {
        HStack(spacing: 16) {
            if let url = URL(string: recipe.photoUrlSmall ?? "") {
                KFImage(url)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
            } else {
                Image(systemName: "fork.knife")
                    .frame(width: 100, height: 100)
                    .background(Color.background)
                    .clipShape(Circle())
            }

            VStack(alignment: .leading, spacing: 8) {
                Text(recipe.name)
                    .font(.headline)

                Text(recipe.cuisine)
                    .font(.subheadline)
            }

            Spacer()

            VStack(spacing: 8) {
                if let sourceUrl = recipe.sourceUrl, URL(string: sourceUrl) != nil {
                    Button(action: {
                        isSourceWebViewPresented = true
                    }) {
                        Image(systemName: "note.text")
                            .foregroundStyle(.link)
                    }
                }
                if let youtubeUrl = recipe.youtubeUrl, URL(string: youtubeUrl) != nil {
                    Button(action: {
                        isYoutubeWebViewPresented = true
                    }) {
                        Image(systemName: "video")
                            .foregroundStyle(.link)
                    }
                }
            }
        }
        .sheet(isPresented: $isSourceWebViewPresented) {
            if let sourceUrl = recipe.sourceUrl, let url = URL(string: sourceUrl) {
                WebView(url: url)
            }
        }
        .sheet(isPresented: $isYoutubeWebViewPresented) {
            if let youtubeUrl = recipe.youtubeUrl, let url = URL(string: youtubeUrl) {
                WebView(url: url)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    RecipeListItemView(viewModel: RecipesViewModel(), recipe: Recipe(id: "1", name: "Pork Adobo", cuisine: "Filipino"))
}
