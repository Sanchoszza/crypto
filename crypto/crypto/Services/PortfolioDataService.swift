//
//  PortfolioDataService.swift
//  crypto
//
//  Created by Alexandra on 13.06.2024.
//

import Foundation
import CoreData

class PortfolioDataService {
    
    private let container: NSPersistentContainer
    private let containerName: String = "PortfolioContainer"
    private let entityNmae: String = "PortfolioEntity"
    
    @Published var savedEntity: [PortfolioEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Error loading Core Data \(error)")
            }
            self.getPortfolioInfo()
        }
    }
    
    //MARK: public
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        
        if let entity = savedEntity.first(where: { $0.coinId == coin.id }) {
            
            if amount > 0 {
                update(entity: entity, amount: amount)
            } else {
                remove(entity: entity)
            }
            
        }
        else {
            add(coin: coin, amount: amount)
        }
//        same
//        if let entity = savedEntity.first(where: { (savedEntity) -> Bool in
//            return savedEntity.coinId == coin.id
//        }) {
//            
//        }
    }
    
    //MARK: private
    
    private func getPortfolioInfo() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityNmae)
        
        do {
           savedEntity = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fatching Portfolio Entoty \(error)")
        }
    }
    
    private func add(coin: CoinModel, amount: Double) {
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinId = coin.id
        entity.amount = amount
        applyChanges()
    }
    
    private func update(entity: PortfolioEntity, amount: Double) {
        entity.amount = amount
        applyChanges()
    }
    
    private func remove(entity: PortfolioEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
            print("Core data saved")
        } catch let error {
            print("Error savinf Core Data \(error)")
        }
    }
    
    private func applyChanges() {
        save()
        getPortfolioInfo()
    }
}
