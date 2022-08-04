//
//  CustomARView.swift
//  ARKit_Barebones
//
//  Created by 이로운 on 2022/08/04.
//

import SwiftUI
import FocusEntity
import RealityKit
import ARKit

class CustomARView: ARView, FEDelegate {
    let focusSquare = FESquare()
    
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
        focusSquare.viewDelegate = self
        focusSquare.delegate = self
        focusSquare.setAutoUpdate(to: true)
        
        // ARView 셋업
        let config = ARWorldTrackingConfiguration() // 장치의 위치를 추적
        config.planeDetection = [.horizontal, .vertical] // 수평과 수직, 둘 다에서 평평한 표면을 감지
        self.session.run(config)
    }
    
    @MainActor required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
