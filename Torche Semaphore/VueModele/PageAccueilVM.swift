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
    private let horloge = ContinuousClock()
    
    
    
    // MARK: Méthodes
    
    func lancerLaSéquence(nombre: Int, fréquence: Int) {
        guard fréquence > 0 else { return }
        let séquence = encadrerBinaire(valeur: nombre)
        let période: Duration = .seconds(1) / fréquence

        // Annule la tâche précédente avant de lancer la nouvelle
        tacheTorche?.cancel()
        estEnCours = true
        
        tacheTorche = Task { [weak self] in
            guard let self = self else { return }
            
            defer {
                Task { @MainActor in
                    self.estEnCours = false  // Remis à false sur le MainActor à la toute fin (même si annulation/erreur)
                }
            }
            
            guard let appareil = AVCaptureDevice.default(for: .video), appareil.hasTorch else {
                print("Torch is not available")
                return
            }
            
            do {
                try appareil.lockForConfiguration()
                defer {
                    appareil.torchMode = .off // Sécurité finale
                    appareil.unlockForConfiguration()
                }
                
                for char in séquence {
                    try Task.checkCancellation()
                    let début = horloge.now
                    appareil.torchMode = (char == "1") ? .on : .off
                    try await horloge.sleep(until: début + période)
                }
                appareil.torchMode = .off
                
            } catch {
                print("Erreur de configuration de la torche : \(error)")
            }
        }
    }
    
    
    func arrêterLaSéquence() {
        tacheTorche?.cancel()
        tacheTorche = nil // Nettoyage
        estEnCours = false
        
        Task {
            if let appareil = AVCaptureDevice.default(for: .video), appareil.hasTorch {
                do {
                    try appareil.lockForConfiguration()
                    appareil.torchMode = .off
                    appareil.unlockForConfiguration()
                } catch {
                    print("Torch could not be turned off")
                }
            }
        }
    }
    
    
    func intEnBinaire(valeur: Int) -> String {
        let binaire = String(valeur, radix: 2)
        return binaire
    }
    
    func encadrerBinaire(valeur: Int) -> String {
        let binaire = String(valeur, radix: 2)
        let binaireEncadré = "10" + binaire + "01"
        return binaireEncadré
    }
    
    func binaireEnInt(valeur: String) -> Int? {
        guard valeur.allSatisfy({ $0 == "0" || $0 == "1" }) else {
                return nil
            }

        return Int(valeur, radix: 2)
    }
}
