//
//  RickMortyViewModel.swift
//  Rick&MortyNoSB
//
//  Created by Bartu Gençcan on 4.02.2022.
//

import Foundation

protocol IRickMortyViewModel {
    func fetchItems()
    func changeLoading()
    
    var rickMortyCharacters: [Result] {get set}
    var rickMortyService: IRickMortyService {get}
    
    var rickMortyOutput: RickMortyOutput? {get}
    
    func setDelegate(output: RickMortyOutput)
    
}

final class RickMortyViewModel: IRickMortyViewModel {
    
    private var isLoading = false
    var rickMortyOutput: RickMortyOutput?
    
    func setDelegate(output: RickMortyOutput) {
        rickMortyOutput = output
    }
    
    
    var rickMortyCharacters: [Result] = []
    let rickMortyService: IRickMortyService
    
    init() {
        rickMortyService = RickMortyService()
    }
    
    func fetchItems() {
        changeLoading()
        
        rickMortyService.fetchAllData { [weak self] response in
            self?.changeLoading()
            self?.rickMortyCharacters = response ?? []
            self?.rickMortyOutput?.saveData(values: self?.rickMortyCharacters ?? [])
        }
    }
    
    func changeLoading() {
        
        isLoading = !isLoading
        rickMortyOutput?.changeLoading(isLoading: isLoading)
        
    }
    
    
 
    
    
}
