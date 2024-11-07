//
//  RecipesListView.swift
//  FetchRecipes
//
//  Created by Bianca Curutan on 11/5/24.
//

import SwiftUI

struct RecipesListView: View {

    @StateObject private var viewModel = RecipesViewModel()

    @State var filteredRecipes: [Recipe] = []
    @State var cuisines: [String] = []
    @State var selectedCuisine: String?
    @State var hasError = false

    var body: some View {
        VStack(spacing: 0) {
            if hasError {
                RecipesErrorView {
                    hasError = false
                    fetchRecipes()
                }
            } else if viewModel.recipes.isEmpty {
                RecipesEmptyView {
                    fetchRecipes()
                }
            } else {
                if cuisines.count > 1 {
                    RecipesFilterView(cuisines: cuisines, selectedCuisine: $selectedCuisine)
                }

                List(filteredRecipes) { recipe in
                    RecipeListItemView(viewModel: viewModel, recipe: recipe)
                }
                .background(Color.background.opacity(0.8))
                .scrollContentBackground(.hidden)
                .onChange(of: selectedCuisine) { _, newCuisine in
                    filteredRecipes = viewModel.filterRecipes(cuisine: newCuisine)
                }
            }
        }
        .onAppear {
            fetchRecipes()
        }
        .refreshable {
            selectedCuisine = nil
            fetchRecipes()
        }
        .padding(.top, 0)
    }

    private func fetchRecipes() {
        viewModel.fetchAllRecipes { recipes, cuisines, error in
            hasError = error != nil

            if let recipes {
                filteredRecipes = recipes
            }

            if let cuisines {
                self.cuisines = cuisines
            }
        }
    }
}

#Preview {
    RecipesListView()
}
