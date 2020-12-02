//
//  ContentView.swift
//  Snake Game
//
//  Created by 전판근 on 2020/12/02.
//

import SwiftUI

enum direction {
    case up, down, left, right
}

struct ContentView: View {
    
    @State var startPosition: CGPoint = .zero
    @State var isStarted = true
    @State var gameOver = false
    @State var dir = direction.down
    @State var positionArray = [CGPoint(x: 0, y: 0)]
    @State var foodPosition = CGPoint(x: 0, y: 0)
    @State var score: Int = 0
    let snakeSize: CGFloat = 15
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
        ZStack {
            Color.black
            ZStack {
                ForEach(0..<positionArray.count, id: \.self) { index in
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: self.snakeSize, height: self.snakeSize)
                        .position(self.positionArray[index])
                }
                Rectangle()
                    .fill(Color.red)
                    .frame(width: snakeSize, height: snakeSize)
                    .position(foodPosition)
                Text("Score: \(score)")
                    .bold()
                    .foregroundColor(.white)
                    .position(x: UIScreen.main.bounds.minX + 50, y: UIScreen.main.bounds.minY + 50)
            }
            .onAppear() {
                self.foodPosition = self.changeRectPosition()
                self.positionArray[0] = self.changeRectPosition()
            }
            .onReceive(timer) { (_) in
                if !self.gameOver {
                    self.changeDirection()
                    if self.positionArray[0] == self.foodPosition {
                        self.positionArray.append(self.positionArray[0])
                        self.foodPosition = self.changeRectPosition()
                        self.score += 10
                    }
                }
            }
            
            if self.gameOver {
                Text("Game Over")
                    .font(.headline)
                    .foregroundColor(.white)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .gesture(DragGesture()
                    .onChanged { gesture in
                        if self.isStarted {
                            self.startPosition = gesture.location
                            self.isStarted.toggle()
                        }
                    }
                    .onEnded { gesture in
                        let xDist = abs(gesture.location.x - self.startPosition.x)
                        let yDist = abs(gesture.location.y - self.startPosition.y)
                        if self.startPosition.y < gesture.location.y && yDist > xDist {
                            self.dir = direction.down
                        }
                        else if self.startPosition.y > gesture.location.y && yDist > xDist {
                            self.dir = direction.up
                        }
                        else if self.startPosition.x > gesture.location.x && yDist < xDist {
                            self.dir = direction.right
                        }
                        else if self.startPosition.x < gesture.location.x && yDist < xDist {
                            self.dir = direction.left
                        }
                        self.isStarted.toggle()
                    }
                )
            }
    
    let minX = UIScreen.main.bounds.minX
    let maxX = UIScreen.main.bounds.maxX
    let minY = UIScreen.main.bounds.minY
    let maxY = UIScreen.main.bounds.maxY
    
    func changeRectPosition() -> CGPoint {
        let rows = Int(maxX/snakeSize)
        let cols = Int(maxY/snakeSize)
        
        let randomX = Int.random(in: 1..<rows) * Int(snakeSize)
        let randomY = Int.random(in: 1..<cols) * Int(snakeSize)
        
        return CGPoint(x: randomX, y: randomY)
    }
    
    func changeDirection() {
        if self.positionArray[0].x < minX || self.positionArray[0].x > maxX && !gameOver {
            gameOver.toggle()
        }
        else if self.positionArray[0].y < minY || self.positionArray[0].y > maxY && !gameOver {
            gameOver.toggle()
        }
        
        var prev = positionArray[0]
        if dir == .down {
            self.positionArray[0].y += snakeSize
        } else if dir == .up {
            self.positionArray[0].y -= snakeSize
        } else if dir == .left {
            self.positionArray[0].x += snakeSize
        } else if dir == .right {
            self.positionArray[0].x -= snakeSize
        }
        
        for index in 1..<positionArray.count {
            let current = positionArray[index]
            positionArray[index] = prev
            prev = current
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
