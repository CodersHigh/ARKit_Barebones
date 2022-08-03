//
//  ModelPickerView.swift
//  ARKit_Barebones
//
//  Created by 이로운 on 2022/08/03.
//

import SwiftUI

struct ModelPickerView: View {
    var models: [String]
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(0..<self.models.count) { index in
                    Button {
                        print(self.models[index])
                    } label: {
                        Image(uiImage: UIImage(named: self.models[index])!)
                            .resizable()
                            .frame(height: 80)
                            .aspectRatio(1/1, contentMode: .fit)
                            .background(Color.white)
                            .cornerRadius(12)
                    }
                }
            }
        }
        .padding()
        .background(Color.black.opacity(0.5))
        
    }
}
