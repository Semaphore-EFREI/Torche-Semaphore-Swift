//
//  PageAccueilVM.swift
//  Torche Semaphore
//
//  Created by Thomas Le Bonnec on 09/05/2025.
//

import Foundation
import SwiftUI
import AVFoundation


class PageAccueilVM: ObservableObject {
    
    // MARK: Attributs
    
    @Published var estEnCours: Bool = false
    
    private var tacheTorche: Task<Void, any Error>? = nil
    
    
    
    // MARK: Méthodes
    
    func lancerLaSéquence(nombre: Int, fréquence: Int) {
        guard fréquence > 0 else { return }
        let séquence = intEnBinaire(nombre: nombre)
        let période = 1.0 / Double(fréquence)

        // Annule la tâche précédente avant de lancer la nouvelle
        tacheTorche?.cancel()
        
        estEnCours = true
        tacheTorche = Task { [weak self] in
            guard let self = self else { return }
            defer {
                Task { @MainActor in
                    self.estEnCours = false  // Remis à false sur le MainActor à la toute fin (même si annulation/erreur)
                    self.basculerTorche(on: false)
                }
            }
            for char in séquence {
                // Vérifie si la Task a été annulée
                try Task.checkCancellation()
                
                let isOn = (char == "1")
                await MainActor.run {
                    self.basculerTorche(on: isOn)
                }
                try? await Task.sleep(nanoseconds: UInt64(période * 1_000_000_000))
            }
            await MainActor.run {
                self.basculerTorche(on: false) // Sécurité
            }
        }
    }
    
    
    func arrêterLaSéquence() {
        tacheTorche?.cancel()
        tacheTorche = nil // Nettoyage
        // Éteint la torche immédiatement
        Task { @MainActor in
            self.basculerTorche(on: false)
        }
        estEnCours = false
    }
    
    
    private func intEnBinaire(nombre: Int) -> String {
        let binaire = String(nombre, radix: 2)
        let binaireEncadré = "10" + binaire + "01"
        print(binaireEncadré)
        return binaireEncadré
    }
    
    
    private func basculerTorche(on: Bool) {
        guard let appareil = AVCaptureDevice.default(for: .video) else { return }

        if appareil.hasTorch {
            do {
                try appareil.lockForConfiguration()

                if on == true {
                    appareil.torchMode = .on
                } else {
                    appareil.torchMode = .off
                }

                appareil.unlockForConfiguration()
            } catch {
                print("Torch could not be used")
            }
        } else {
            print("Torch is not available")
        }
    }
}
