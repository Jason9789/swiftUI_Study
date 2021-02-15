//
//  ContentView.swift
//  DarkModeToggle
//
//  Created by 전판근 on 2021/02/15.
//

import SwiftUI

struct ContentView: View {
    let darkBackground = UIColor(
        red: 0.189, green: 0.187, blue: 0.256, alpha: 1.0
    )
    
    @State private var darkmode = false
    var body: some View {
        ZStack {
            Color(darkmode ? darkBackground : .white)
                .edgesIgnoringSafeArea(.all)
            
            ZStack {
                Color(self.darkmode ? UIColor.black : UIColor(red: 0.67, green: 0.81, blue: 1.00, alpha: 1.00))
                MiniImages(darkmode: $darkmode)
            }
            .frame(width: 100, height: 50)
            .mask(
                Capsule()
                    .foregroundColor(self.darkmode ? Color.black : Color(UIColor(red: 0.67, green: 0.81, blue: 1.00, alpha: 1.00)))
            )
            ZStack {
                Circle()
                    .foregroundColor(darkmode ? .white : .yellow)
                    .frame(width: 45, height: 45)
                Circle()
                    .foregroundColor(self.darkmode ? Color.black : Color(UIColor(red: 0.67, green: 0.81, blue: 1.00, alpha: 1.00)))
                    .offset(x: darkmode ? -22.5 : -45)
                    .rotationEffect(.degrees(darkmode ? 45 : 0))
                    .frame(width: 45, height: 45)
            }
            .offset(x: darkmode ? 23 : -23)
            .mask(
                Circle()
                    .frame(width: 45, height: 45)
                    .offset(x: darkmode ? 23 : -23)
            )
        }
        
        .onAppear() {
            Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { _ in
                withAnimation(Animation.easeIn) {
                    self.darkmode.toggle()
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
