//
//  RandomActivityView.swift
//  WebAPITest
//
//  Created by Apple on 29/12/2022.
//

import SwiftUI

struct RandomActivityView: View {
    @State var activityName = ""
    @State var activityType = ""
    @State var activityPrice = 0.0
    
    let activityApi = "https://www.boredapi.com/api/activity"
    
    
    func fetchRandomActivity() async -> Activity? {
        var activity: Activity? = nil
        
        guard let activityUrl = URL(string: activityApi) else {
            print("Invalid URL")
            return nil
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: activityUrl)
            let decoder = JSONDecoder()
            activity = try decoder.decode(Activity.self, from: data)
            
        } catch {
            print("Failed to load the remote data")
        }
        
        return activity
    }
    
    var body: some View {
        VStack(alignment: .leading){
            Text(activityName)
                .font(.system(size: 100,weight: .black, design: .rounded))
                .minimumScaleFactor(0.5)
            Text(activityType)
                .font(.headline)
                .foregroundColor(.gray)
            Text("$\(activityPrice.formatted())")
                .font(.system(size: 70, weight: .black, design: .rounded))
            
            Button{
                Task {
                    if let activity = await fetchRandomActivity() {
                        activityName = activity.name
                        activityType = activity.type
                        activityPrice = activity.price
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
            if let activity = await fetchRandomActivity(){
                activityName = activity.name
                activityType = activity.type
                activityPrice = activity.price
            }
        }
    }
}

struct RandomActivityView_Previews: PreviewProvider {
    static var previews: some View {
        RandomActivityView()
    }
}

struct Activity: Codable {
    var name: String
    var type: String
    var participants: Int
    var price: Double
    
    enum CodingKeys: String, CodingKey {
        case name = "activity"
        case type
        case participants
        case price
    }
}
