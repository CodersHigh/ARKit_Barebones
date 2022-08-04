//
//  ContentView.swift
//  ARKit_Barebones
//
//  Created by 이로운 on 2022/08/03.
//

import SwiftUI

struct ContentView : View {
    @State private var placementMode = false
    @State private var selectedModel: Model?
    @State private var modelConfirmedForPlacement: Model?
    
    // 파일 이름에서 .usdz 확장자 제거하여 모델 이름 얻기
    private var models: [Model] = {
        guard let path = Bundle.main.resourcePath, let files = try? FileManager.default.contentsOfDirectory(atPath: path) else {
            return []
        }
        var models: [Model] = []
        for fileName in files where fileName.hasSuffix("usdz") {
            let modelName = fileName.replacingOccurrences(of: ".usdz", with: "")
            let model = Model(modelName: modelName)
            models.append(model)
        }
        return models
    }()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ARViewContainer(modelConfirmedForPlacement: self.$modelConfirmedForPlacement)
            
            // 배치 모드라면 PlacementButtonsView / 아니라면 ModelPickerView 표시
            if self.placementMode {
                PlacementButtonsView(placementMode: self.$placementMode, selectedModel: self.$selectedModel, modelConfirmedForPlacement: self.$modelConfirmedForPlacement)
            } else {
                ModelPickerView(placementMode: self.$placementMode, selectedModel: self.$selectedModel, models: self.models)
            }
            
        }
    }
    
}
