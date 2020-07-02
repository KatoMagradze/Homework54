//
//  APIService.swift
//  Homework54
//
//  Created by Kato on 7/2/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import Foundation

class APIService {
    
    typealias completion = (AllCharacters) -> ()
    
    func fetchCharacters(completion: @escaping (AllCharacters) -> ()) {
        
        guard let url = URL(string: "https://rickandmortyapi.com/api/character/") else {return}
        
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            
            guard let data = data else {return}
            
            do {
                let decoder = JSONDecoder()
                let characters = try decoder.decode(AllCharacters.self, from: data)

                completion(characters)
                
            } catch {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
    
}
