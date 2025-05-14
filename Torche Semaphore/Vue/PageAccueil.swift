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
    
    @State var valeurDécimale: Int? = nil
    @State var valeurBinaire: String = ""
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
                ChampDeNombre(entête: "Valeur à transmettre (décimal)", exemple: "823 766", valeur: $valeurDécimale)
                ChampDeTexte(entête: "Valeur à transmettre (binaire)", exemple: "11001001000111010110", valeur: $valeurBinaire)
                ChampDeNombre(entête: "Fréquence en Hz (= bits par seconde)", exemple: "20", valeur: $fréquence)
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
            
            
            EncartInfos(valeur: valeurDécimale ?? 823766, fréquence: fréquence ?? 20)
            
            
            if vm.estEnCours {
                Bouton(style: .secondaire, titre: "Annuler") {
                    vm.arrêterLaSéquence()
                }
            } else {
                Bouton(titre: "Envoyer") {
                    vm.lancerLaSéquence(nombre: valeurDécimale ?? 823766, fréquence: fréquence ?? 20)
                }
            }
        }
        .onChange(of: valeurBinaire) { ancienneValeur, nouvelleValeur in
            valeurBinaire = nouvelleValeur.filter { $0 == "0" || $0 == "1" }
            valeurDécimale = vm.binaireEnInt(valeur: nouvelleValeur)
        }
        .onChange(of: valeurDécimale ?? -1) { ancienneValeur, nouvelleValeur in
            if nouvelleValeur == -1 {
                valeurBinaire = ""
                return
            }
            valeurBinaire = vm.intEnBinaire(valeur: nouvelleValeur)
        }
    }
}





#Preview {
    PageAccueil()
}
