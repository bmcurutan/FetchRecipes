//
//  RecipesFilterView.swift
//  FetchRecipes
//
//  Created by Bianca Curutan on 11/7/24.
//

import SwiftUI

struct RecipesFilterView: View {

    @State var cuisines: [String]
    @Binding var selectedCuisine: String?

    var filterAction: ((String) -> ())?

    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 8) {
                ForEach(cuisines, id: \.self) { cuisine in
                    Button(action: {
                        selectedCuisine = selectedCuisine != cuisine ? cuisine : nil
                    }) {
                        Text("\(cuisine)")
                            .padding()
                            .background(selectedCuisine != cuisine ? Color(UIColor.secondarySystemBackground) : .blue)
                            .foregroundColor(selectedCuisine != cuisine ? .black : .white)
                            .cornerRadius(8)
                    }
                }
            }
            .frame(maxHeight: 48)
            .padding()
        }
        .background(Color.background)
    }
}
