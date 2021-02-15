//
//  MiniImages.swift
//  DarkModeToggle
//
//  Created by 전판근 on 2021/02/15.
//

import SwiftUI

struct MiniImages: View {
    
    @Binding var darkmode: Bool
    
    var body: some View {
        ZStack {
            Image(systemName: "cloud.fill")
                .resizable()
                .foregroundColor(.white)
                .frame(width: 15, height: 10)
                .offset(x: 15, y: 0)
                .opacity(darkmode ? 0 : 1)
            Image(systemName: "cloud.fill")
                .resizable()
                .foregroundColor(.white)
                .frame(width: 15, height: 10)
                .offset(x: 30, y: 10)
                .opacity(darkmode ? 0 : 1)
            
            Image(systemName: "star.fill")
                .resizable()
                .foregroundColor(.yellow)
                .frame(width: 5, height: 5)
                .offset(x: -20, y: -12)
                .opacity(darkmode ? 1 : 0)
            Image(systemName: "star.fill")
                .resizable()
                .foregroundColor(.yellow)
                .frame(width: 5, height: 5)
                .offset(x: -5, y: -5)
                .opacity(darkmode ? 1 : 0)
            Image(systemName: "star.fill")
                .resizable()
                .foregroundColor(.yellow)
                .frame(width: 5, height: 5)
                .offset(x: -25, y: 10)
                .opacity(darkmode ? 1 : 0)
        }
    }
}
