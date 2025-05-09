//
//  BoutonRond.swift
//  Torche Semaphore
//
//  Created by Thomas Le Bonnec on 09/05/2025.
//

import SwiftUI

struct BoutonRond: View {
    
    // MARK: Attributs
    
    var image: String
    var action: () -> Void
    
    
    
    // MARK: Vue
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: image)
                .foregroundStyle(Color.bleu)
                .frame(width: 50, height: 50)
                .background(Color.fondPrimaire)
                .cornerRadius(25)
        }
        .contentShape(Rectangle())
    }
}




#Preview {
    BoutonRond(image: "info") {
        print("OK")
    }
}
