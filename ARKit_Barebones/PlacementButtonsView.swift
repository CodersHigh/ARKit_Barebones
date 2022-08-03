//
//  PlacementButtonsView.swift
//  ARKit_Barebones
//
//  Created by 이로운 on 2022/08/03.
//

import SwiftUI

struct PlacementButtonsView: View {
    @Binding var isPlacementEnabled: Bool
    @Binding var selectedModel: String?
    @Binding var modelConfirmedForPlacement: String?
    
    var body: some View {
        
        HStack {
            // Cancel 버튼
            Button {
                self.resetPlacement()
            } label: {
                Image(systemName: "xmark")
                    .frame(width: 60, height: 60)
                    .font(.title)
                    .background(Color.white.opacity(0.75))
                    .cornerRadius(30)
                    .padding()
            }
            // Confirm 버튼
            Button {
                self.resetPlacement()
                self.modelConfirmedForPlacement = self.selectedModel
            } label: {
                Image(systemName: "checkmark")
                    .frame(width: 60, height: 60)
                    .font(.title)
                    .background(Color.white.opacity(0.75))
                    .cornerRadius(30)
                    .padding()
            }
        }
        
    }
    
    func resetPlacement() {
        self.isPlacementEnabled = false
        self.selectedModel = nil
    }
    
}
