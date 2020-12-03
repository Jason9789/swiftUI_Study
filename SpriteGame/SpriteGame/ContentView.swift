//
//  ContentView.swift
//  SpriteKit
//
//  Created by 전판근 on 2020/12/03.
//

import SwiftUI
import SpriteKit

class GameScene: SKScene {
    
    let colors: [UIColor] = [.red, .orange, .yellow, .green, .cyan, .magenta]
    
    override func didMove(to view: SKView) {
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let sphere = SKShapeNode(circleOfRadius: 25)
        let randomNumber = Int.random(in: 0...5)
        
        sphere.fillColor = colors[randomNumber]
        sphere.lineWidth = 2
        sphere.position = location
        sphere.physicsBody = SKPhysicsBody(circleOfRadius: 25)
        addChild(sphere)
    }
}


struct ContentView: View {
    
    var scene: SKScene {
        let scene = GameScene()
        scene.size = CGSize(width: 300, height: 400)
        scene.scaleMode = .fill
        return scene
    }
    
    var body: some View {
        SpriteView(scene: scene)
            .frame(width: 300, height: 400)
            .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
