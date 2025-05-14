//
//  BoutonCopier.swift
//  Torche Semaphore
//
//  Created by Thomas Le Bonnec on 14/05/2025.
//

import SwiftUI

struct BoutonCopier<T: CustomStringConvertible>: View {
    
    // MARK: Attribut
    
    var valeur: T
    
    
    
    // MARK: Vue
    
    var body: some View {
        Button {
            UIPasteboard.general.string = valeur as? String
        } label: {
            Image(systemName: "square.on.square")
                .frame(width: 28, height: 28)
                .foregroundStyle(Color.bleu)
        }

    }
}





#Preview {
    BoutonCopier(valeur: "Bonnour")
}
