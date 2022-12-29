//
//  CatDogView.swift
//  WebAPITest
//
//  Created by Apple on 29/12/2022.
//

import SwiftUI

struct CatDogView: View {
    var body: some View {
        AsyncImage(url: URL(string: "https://source.unsplash.com/random/?dog,cat")) {image in
            image
                .resizable()
                .scaledToFit()
            
        }
    placeholder: {
        Text("Loading...")
    }
    }
}

struct CatDogView_Previews: PreviewProvider {
    static var previews: some View {
        CatDogView()
    }
}
