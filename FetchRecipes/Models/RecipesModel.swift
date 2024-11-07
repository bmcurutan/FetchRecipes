//
//  RecipesModel.swift
//  FetchRecipes
//
//  Created by Bianca Curutan on 11/6/24.
//

import SwiftUI
import WebKit

struct Recipes: Decodable {
    var recipes: [Recipe]
}

struct Recipe: Decodable, Identifiable {
    var id: String
    var name: String
    var cuisine: String
    var photoUrlLarge: String?
    var photoUrlSmall: String?
    var sourceUrl: String?
    var youtubeUrl: String?

    private enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case photoUrlLarge = "photo_url_large"
        case photoUrlSmall = "photo_url_small"
        case sourceUrl = "source_url"
        case youtubeUrl = "youtube_url"
        case name, cuisine
    }
}

struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}
