//
//  ContentView.swift
//  WebAPITest
//
//  Created by Apple on 29/12/2022.
//

import SwiftUI

struct ContentView: View {
    var activities = ["Meditate", "Random Suggestions", "Tell me a Joke", "Random cat/dog photos"]
    var icon = ["🏥", "🏞️", "😄", "🐱"]
    var body: some View {
        NavigationStack {
            List {
                ForEach(activities.indices, id: \.self){ index in
                    NavigationLink(value: index) {
                        HStack{
                            Text(icon[index])
                            Text(activities[index])
                        }
                        .font(.system(size: 20, weight: .bold,design: .rounded))
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Boring App")
            .navigationDestination(for: Int.self){ index in
                switch index {
                case 0: MeditateView()
                case 1: RandomActivityView()
                case 2: JokeView()
                case 3: CatDogView()
                default: EmptyView()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
