//
//  ContentView.swift
//  Torche Semaphore
//
//  Created by Thomas Le Bonnec on 09/05/2025.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: Attributs
    
    @State var afficherInfos = false
    
    
    
    // MARK: Vue
    
    var body: some View {
        ZStack {
            ScrollView {
                PageAccueil()
                    .padding(24)
            }
            .background(Color.fondSecondaire)
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    BoutonRond(image: "info") {
                        afficherInfos = true
                    }
                }
            }
            .padding(24)
        }
        .sheet(isPresented: $afficherInfos) {
            PageInfos()
        }
    }
}

#Preview {
    ContentView()
}
