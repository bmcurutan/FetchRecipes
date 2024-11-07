//
//  RecipesViewModelTests.swift
//  FetchRecipesTests
//
//  Created by Bianca Curutan on 11/5/24.
//

import Testing
import XCTest
@testable import FetchRecipes

struct RecipesViewModelTests {

    private let viewModel = RecipesViewModel()
    private let mockRecipes = [
        Recipe(id: "1", name: "Pork Adobo", cuisine: "Filipino"),
        Recipe(id: "2", name: "Tortière", cuisine: "Canadian"),
        Recipe(id: "3", name: "Bibimbap", cuisine: "Korean"),
        Recipe(id: "4", name: "Salmon Teriyaki", cuisine: "Japanese"),
        Recipe(id: "5", name: "Poutine", cuisine: "Canadian"),
    ]

    @Test func testFetchAllRecipes1() async throws {
        viewModel.fetchAllRecipes { recipes, cuisines, error in
            XCTAssertNil(error)

            if let recipes {
                XCTAssertTrue(recipes.count > 0)
            }

            if let cuisines {
                XCTAssertTrue(cuisines.count > 0)
            }
        }
    }

    @Test func testFetchAllRecipes2() async throws {
        viewModel.fetchRecipes(with: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json") { recipes, cuisines, error in
            XCTAssertNil(error)

            if let recipes {
                XCTAssertTrue(recipes.count > 0)
            }

            if let cuisines {
                XCTAssertTrue(cuisines.count > 0)
            }
        }
    }

    @Test func testFetchEmptyRecipes() async throws {
        viewModel.fetchRecipes(with: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json") { recipes, cuisines, error in
            XCTAssertNil(error)

            if let recipes {
                XCTAssertEqual(recipes.count, 0)
            }

            if let cuisines {
                XCTAssertEqual(cuisines.count, 0)
            }
        }
    }

    @Test func testFetchMalformedRecipes() async throws {
        viewModel.fetchRecipes(with: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json") { recipes, cuisines, error in
            XCTAssertNotNil(error)
            XCTAssertNil(recipes)
            XCTAssertNil(cuisines)
        }
    }

    @Test func testFilterRecipes() {
        viewModel.recipes = mockRecipes
        let filteredRecipes = viewModel.filterRecipes(cuisine: "Canadian")
        XCTAssertEqual(filteredRecipes.count, 2)
    }

    @Test func testFilterRecipesEmpty() {
        viewModel.recipes = mockRecipes
        let filteredRecipes = viewModel.filterRecipes(cuisine: "Italian")
        XCTAssertEqual(filteredRecipes.count, 0)
    }
}
