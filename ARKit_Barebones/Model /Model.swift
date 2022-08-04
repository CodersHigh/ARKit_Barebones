//
//  Model.swift
//  ARKit_Barebones
//
//  Created by 이로운 on 2022/08/04.
//

import UIKit
import RealityKit
import Combine

class Model {
    var modelName: String
    var image: UIImage
    var modelEntity: ModelEntity?
    
    private var cancellable: AnyCancellable? = nil
    
    init(modelName: String) {
        self.modelName = modelName
        self.image = UIImage(named: modelName)!
        let fileName = modelName + ".usdz"
        self.cancellable = ModelEntity.loadModelAsync(named: fileName)
            .sink(receiveCompletion: { loadCompletion in
                // Handle Error
                print("Unable to load modelEntiry for modelName: \(self.modelName)")
            }, receiveValue: { modelEntity in
                // Get out modelEntity
                self.modelEntity = modelEntity
                print("Successfully loaded modelEntity for modelName: \(self.modelName)")
            })
    }
}
