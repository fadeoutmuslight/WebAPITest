//
//  JokeView.swift
//  WebAPITest
//
//  Created by Apple on 29/12/2022.
//

import SwiftUI

struct JokeView: View {
    @State var jokeSetup = ""
    @State var jokeType = ""
    @State var jokePunchline = ""
    
    let jokeApi = "https://official-joke-api.appspot.com/random_joke"
    
    func fetchRandomActivity() async -> Joke? {
        var joke: Joke? = nil
        
        guard let activityUrl = URL(string: jokeApi) else {
            print("Invalid URL")
            return nil
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: activityUrl)
            let decoder = JSONDecoder()
            joke = try decoder.decode(Joke.self, from: data)
            
        } catch {
            print("Failed to load the remote data")
        }
        
        return joke
    }
    
    var body: some View {
        VStack{
            Text(jokeSetup)
                .font(.system(size: 100,weight: .black, design: .rounded))
                .minimumScaleFactor(0.5)
            Text(jokeType)
                .font(.headline)
                .foregroundColor(.gray)
            Text(jokePunchline)
                .font(.system(size: 40, weight: .black, design: .rounded))
            Button{
                Task {
                    if let joke = await fetchRandomActivity(){
                        jokeSetup = joke.setup
                        jokeType = joke.type
                        jokePunchline = joke.punchline
                    }
                }
            }label: {
                Text("Another Suggestion")
            }
            .tint(.purple)
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
        }
        .padding()
        .task {
            if let joke = await fetchRandomActivity(){
                jokeSetup = joke.setup
                jokeType = joke.type
                jokePunchline = joke.punchline
            }
        }
    }
        
    
}



struct JokeView_Previews: PreviewProvider {
    static var previews: some View {
        JokeView()
    }
}

struct Joke: Codable {
    var setup: String
    var type: String
    var punchline: String
}
