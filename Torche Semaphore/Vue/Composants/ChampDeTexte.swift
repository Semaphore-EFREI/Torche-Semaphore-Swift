//
//  ChampDeTexte.swift
//  Torche Semaphore
//
//  Created by Thomas Le Bonnec on 09/05/2025.
//

import SwiftUI

struct ChampDeTexte: View {
    
    // MARK: Attributs
    
    var entête: String
    var exemple: String
    @Binding var valeur: String
    
    @FocusState private var champFocus: Bool
    
    
    
    // MARK: Vue
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(entête)
                .foregroundStyle(Color.texteTertiaire)
                .padding(.leading, 2)
            
            HStack {
                Group {
                    TextField("", text: $valeur, prompt: Text(exemple).foregroundStyle(Color.texteQuaternaire))
                        .foregroundStyle(Color.textePrimaire)
                        .keyboardType(.numberPad)
                        .focused($champFocus)
                }
                .frame(height: 42)
                .padding(.horizontal, 14)
                .background(Color.fondPrimaire)
                .cornerRadius(8)
                
                BoutonCopier(valeur: valeur.isEmpty ? exemple : valeur)
            }
        }
    }
}





#Preview {
    ChampDeTexte(entête: "Entête", exemple: "96543", valeur: .constant("01001011010"))
}
