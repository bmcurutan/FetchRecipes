//
//  RecipesModelTests.swift
//  FetchRecipes
//
//  Created by Bianca Curutan on 11/9/24.
//

import XCTest
@testable import FetchRecipes

final class RecipesModelTests: XCTestCase {

    private let validJSON = """
        {
        "recipes": [
        {
        "cuisine": "Malaysian",
        "name": "Apam Balik",
        "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
        "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
        "source_url": "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
        "uuid": "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
        "youtube_url": "https://www.youtube.com/watch?v=6R8ffRRJcrg"
        }
        ]
        }
    """.data(using: .utf8)!

    private let validJSONWithoutOptionalProps = """
        {
        "recipes": [
        {
        "cuisine": "Malaysian",
        "name": "Apam Balik",
        "uuid": "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
        }
        ]
        }
    """.data(using: .utf8)!

    private let invalidJSON = """
        {
        "recipes": [
        {
        "cuisine": "Malaysian"
        }
        ]
        }
    """.data(using: .utf8)!

    func testDecodingRecipeValidJSON() {
        do {
            let recipes = try JSONDecoder().decode(Recipes.self, from: validJSON)
            XCTAssertEqual(recipes.recipes.count, 1)

            guard let recipe = recipes.recipes.first else {
                XCTFail("Unable to get first recipe")
                return
            }

            XCTAssertEqual(recipe.id, "0c6ca6e7-e32a-4053-b824-1dbf749910d8")
            XCTAssertEqual(recipe.name, "Apam Balik")
            XCTAssertEqual(recipe.cuisine, "Malaysian")
            XCTAssertEqual(recipe.photoUrlLarge, "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg")
            XCTAssertEqual(recipe.photoUrlSmall, "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg")
            XCTAssertEqual(recipe.sourceUrl, "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ")
            XCTAssertEqual(recipe.youtubeUrl, "https://www.youtube.com/watch?v=6R8ffRRJcrg")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testDecodingRecipeValidJSONWithoutOptionalProps() {
        do {
            let recipes = try JSONDecoder().decode(Recipes.self, from: validJSONWithoutOptionalProps)
            XCTAssertEqual(recipes.recipes.count, 1)

            guard let recipe = recipes.recipes.first else {
                XCTFail("Unable to get first recipe")
                return
            }
            
            XCTAssertEqual(recipe.id, "0c6ca6e7-e32a-4053-b824-1dbf749910d8")
            XCTAssertEqual(recipe.name, "Apam Balik")
            XCTAssertEqual(recipe.cuisine, "Malaysian")
            XCTAssertNil(recipe.photoUrlLarge)
            XCTAssertNil(recipe.photoUrlSmall)
            XCTAssertNil(recipe.sourceUrl)
            XCTAssertNil(recipe.youtubeUrl)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testDecodingRecipeInvalidJSONWithoutRequiredFields() {
        do {
            let _ = try JSONDecoder().decode(Recipes.self, from: invalidJSON)
            XCTFail("Decoding failed: required fields missing")
        } catch {
            XCTAssertTrue(true)
        }
    }
}
