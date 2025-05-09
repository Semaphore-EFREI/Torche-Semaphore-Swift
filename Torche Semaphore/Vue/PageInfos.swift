//
//  PageInfos.swift
//  Torche Semaphore
//
//  Created by Thomas Le Bonnec on 09/05/2025.
//

import SwiftUI

struct PageInfos: View {
    
    // MARK: Vue
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Informations")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.top, 16)
                    .padding(.bottom, 24)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("La valeur est convertit en binaire, et la taille du nombre binaire varie donc en fonction de la valeur.")
                
                Group {
                    Text("823766 → 11001001000111010110 (20 bits)")
                    Text("4821 → 1001011010101 (13 bits)")
                }
                .foregroundStyle(Color.texteTertiaire)
                
                Text("Pour que la balise puisse savoir quand commence et quand se termine la séquence, on ajoute \"10\" au début et \"01\" à la fin.")
                
                Group {
                    Text("4821 → ")
                    + Text("10").fontWeight(.bold)
                    + Text("1001011010101")
                    + Text("01").fontWeight(.bold)
                    + Text(" (17 bits)")
                }
                .foregroundStyle(Color.texteTertiaire)
                
                Text("Lors de la transmission, il n'y a pas d'écart entre les bits. Si deux \"1\" se suivent, alors le flash reste allumé plus longtemps.")
            }
            .foregroundStyle(Color.textePrimaire)
        }
        .padding(24)
        .background(Color.fondSecondaire)
    }
}





#Preview {
    PageInfos()
}
