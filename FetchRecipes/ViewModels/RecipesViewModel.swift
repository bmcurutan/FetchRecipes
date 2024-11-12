//
//  RecipesViewModel.swift
//  FetchRecipes
//
//  Created by Bianca Curutan on 11/6/24.
//

import UIKit

class RecipesViewModel: ObservableObject {

    @Published var recipes: [Recipe] = []

    private let allRecipesUrl = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"

    func fetchAllRecipes(completion: @escaping (_ recipes: [Recipe]?, _ cuisines: [String]?, _ error: Error?) -> Void) {
        fetchRecipes(with: allRecipesUrl, completion: completion)
    }

    func fetchRecipes(with urlString: String, completion: @escaping (_ recipes: [Recipe]?, _ cuisines: [String]?, _ error: Error?) -> Void) {
        guard let url = URL(string: urlString) else { return }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in

            if let error {
                completion(nil, nil, error)
                return
            }

            guard let data else { return }

            do {
                let recipes = try JSONDecoder().decode(Recipes.self, from: data).recipes
                let cuisines = Array(Set(recipes.map { $0.cuisine })).sorted()
                DispatchQueue.main.async { [weak self] in
                    self?.recipes = recipes
                    completion(recipes, cuisines, nil)
                }
            } catch {
                print(error.localizedDescription)
                completion(nil, nil, error)
            }
        }
        
        task.resume()
    }

    func filterRecipes(cuisine: String?) -> [Recipe] {
        if let cuisine {
            return recipes.filter { $0.cuisine == cuisine }
        } else {
            return recipes
        }
    }

    func fetchRandomRecipe() -> Recipe? {
        return recipes.randomElement()
    }
}
