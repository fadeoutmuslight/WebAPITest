//
//  MeditateView.swift
//  WebAPITest
//
//  Created by Apple on 29/12/2022.
//

import SwiftUI

struct MeditateView: View {
    @State var isStart = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var timeRemaining = 60
    var body: some View {
        VStack{
            Text("take a moment to pause...")
                .font(.system(.largeTitle, design: .rounded,weight: .black))
                .multilineTextAlignment(.center)
            Spacer()
            
            
            ZStack{
                ForEach(0...2, id: \.self){ index in
                    ZStack{
                        Circle()
                            .fill(.blue)
                            .frame(width: 160,height: 160)
                            .offset(y: isStart ? 80 : 0)
                        Circle()
                            .fill(.mint)
                            .frame(width: 160,height: 160)
                            .offset(y: isStart ? -80 : 0)
                    }
                    .rotationEffect(.degrees(Double(index)*60.0))
                }
                Text("\(timeRemaining)")
                    .font(.system(size: 40.0,weight: .black))
                    .foregroundColor(.white)
            }
            .opacity(0.5)
            Spacer()
            Button{
                withAnimation(.easeInOut(duration: 5.0).repeatForever()){
                    isStart = true
                }
            }label: {
                Text("Start")
            }
            .tint(.blue)
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            
            
        }
        .onReceive(timer){ _ in
            if !isStart {return}
            if timeRemaining > 0 {
                timeRemaining -= 1
            }else{
                withAnimation{
                    isStart = false
                    timeRemaining = 60
                }
            }
        }
    }
}

struct MeditateView_Previews: PreviewProvider {
    static var previews: some View {
        MeditateView()
    }
}
