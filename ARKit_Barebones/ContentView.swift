//
//  ContentView.swift
//  ARKit_Barebones
//
//  Created by 이로운 on 2022/08/03.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    var models: [String] = ["teapot", "toy_biplane", "toy_drummer", "toy_robot_vintage"]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ARViewContainer()
            ModelPickerView(models: self.models)
        }
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}
