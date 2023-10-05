//
//  TextFieldSearcher.swift
//  DevCodeReleases
//
//  Created by Raul on 12/6/23.
//

import SwiftUI

struct TextFieldSearcher: View {
    @Binding var searchText: String
    var body: some View {
        VStack {
            TextField(LocalizedKeys.Home.search, text: $searchText)
                .padding(8)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Spacer()
                        if !searchText.isEmpty {
                            Button(action: {
                                searchText = ""
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(8)
                            }
                        }
                        
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .padding(8)
                    }
                )
                .padding()
        }
    }
}
