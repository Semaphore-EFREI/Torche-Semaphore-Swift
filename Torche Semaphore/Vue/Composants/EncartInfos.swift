//
//  EncartInfos.swift
//  Torche Semaphore
//
//  Created by Thomas Le Bonnec on 09/05/2025.
//

import SwiftUI

struct EncartInfos: View {
    
    // MARK: Attributs
    
    var valeur: Int
    var fréquence: Int
    
    
    
    // MARK: Vue
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Text("Binaire encadré")
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.textePrimaire)
                
                Spacer()
                
                Text(encadrerBinaire(valeur: valeur))
                    .foregroundStyle(Color.texteTertiaire)
            }
            
            HStack {
                Text("Nombre de bits")
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.textePrimaire)
                
                Spacer()
                
                Text("\(encadrerBinaire(valeur: valeur).count)")
                    .foregroundStyle(Color.texteTertiaire)
            }
            
            HStack {
                Text("Durée du signal")
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.textePrimaire)
                
                Spacer()
                
                Text(obtenirDurée(valeur: valeur, fréquence: fréquence))
                    .foregroundStyle(Color.texteTertiaire)
            }
        }
        .font(.caption)
        .padding()
        .background(Color.fondPrimaire)
        .cornerRadius(8)
    }
    
    
    
    // MARK: Méthodes
    
    func intEnBinaire(valeur: Int) -> String {
        let binaire = String(valeur, radix: 2)
        return binaire
    }
    
    func encadrerBinaire(valeur: Int) -> String {
        let binaire = String(valeur, radix: 2)
        let binaireEncadré = "10" + binaire + "01"
        return binaireEncadré
    }
    
    func obtenirDurée(valeur: Int, fréquence: Int) -> String {
        let binaireEncadré = encadrerBinaire(valeur: valeur)
        let tailleBinaire = binaireEncadré.count
        let durée: Float = Float(tailleBinaire) / Float(fréquence)
        return "\(durée)s"
    }
}





#Preview {
    EncartInfos(valeur: 823766, fréquence: 20)
}
