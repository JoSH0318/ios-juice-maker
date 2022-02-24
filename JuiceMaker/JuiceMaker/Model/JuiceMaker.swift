//
//  JuiceMaker - JuiceMaker.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import Foundation

struct JuiceMaker {
    var fruitStore = FruitStore()
    
    func selectMenu(_ juice: Juice) {
        order(juice.recipe)
    }
    
    func order(_ recipe: [Fruit: Int]) {
        do {
            try makeJuice(by: recipe)
        } catch let error as OrderError {
            print(error.description)
        } catch {
            print(error)
        }
    }

    func makeJuice(by recipe: [Fruit: Int]) throws {
        for (fruit, requiredQuantity) in recipe {
            guard let fruitStock = fruitStore.fruitInventory[fruit] else {
                throw OrderError.wrongFormat
            }
            guard fruitStock >= requiredQuantity else {
                throw OrderError.outOfStock
            }
            fruitStore.fruitInventory[fruit] = fruitStock - requiredQuantity
        }
    }
}
