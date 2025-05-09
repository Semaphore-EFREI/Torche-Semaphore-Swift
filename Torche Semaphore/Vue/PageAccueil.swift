//
//  PageAccueil.swift
//  Torche Semaphore
//
//  Created by Thomas Le Bonnec on 09/05/2025.
//

import SwiftUI

struct PageAccueil: View {
    
    // MARK: Attributs
    
    @StateObject var vm = PageAccueilVM()
    
    @State var valeur: Int? = nil
    @State var fréquence: Int? = nil
    
    
    
    // MARK: Vue
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            Text("Torche Sémaphore")
                .foregroundStyle(Color.textePrimaire)
                .font(.title)
                .fontWeight(.semibold)
                .padding(.top, 16)
                .padding(.bottom, 24)
            
            
            VStack(spacing: 24) {
                ChampDeTexte(entête: "Valeur à transmettre", exemple: "823 766", valeur: $valeur)
                ChampDeTexte(entête: "Fréquence en Hz (= bits par seconde)", exemple: "20", valeur: $fréquence)
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Terminer") {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                    .foregroundStyle(Color.bleu)
                }
            }
            
            
            EncartInfos(valeur: valeur ?? 823766, fréquence: fréquence ?? 20)
            
            
            if vm.estEnCours {
                Bouton(style: .secondaire, titre: "Annuler") {
                    vm.arrêterLaSéquence()
                }
            } else {
                Bouton(titre: "Envoyer") {
                    vm.lancerLaSéquence(nombre: valeur ?? 823766, fréquence: fréquence ?? 20)
                }
            }
        }
    }
}





#Preview {
    PageAccueil()
}
