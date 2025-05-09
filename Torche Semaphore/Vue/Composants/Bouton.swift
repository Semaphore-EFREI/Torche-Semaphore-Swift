//
//  Bouton.swift
//  Torche Semaphore
//
//  Created by Thomas Le Bonnec on 09/05/2025.
//

import SwiftUI

struct Bouton: View {
    
    // MARK: Attributs
    
    var style: Style = .primaire
    var titre: String
    var action: () -> Void
    
    
    
    // MARK: Vue
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(titre)
                .foregroundStyle(style == .primaire ? Color.texteInverse : Color.bleu)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(style == .primaire ? Color.bleu : Color.fondPrimaire)
                .cornerRadius(8)
        }
        .contentShape(Rectangle())
    }
    
    
    
    // MARK: Objets
    
    enum Style {
        case primaire, secondaire
    }
}





#Preview {
    Bouton(titre: "Bouton") {
        print("Hello")
    }
}
