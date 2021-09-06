//
//  NetworkDataManager.swift
//  testAppForAvito
//
//  Created by Роман on 03.09.2021.
//

import Foundation


protocol NetworkDataManagerDelegate: AnyObject {
    func updateInterface( _: NetworkDataManager, with currenData: CurrentData)
}

class NetworkDataManager {
    weak var delegate: NetworkDataManagerDelegate?
    func fetchCurrentData() {
        let urlString = "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c"
        guard let url = URL(string: urlString) else {return}
        let urlSession = URLSession(configuration: .default)
        let task = urlSession.dataTask(with: url) { data, responce, error in
            if let data = data {
                if let currentData = self.parseJSON(withData: data){
                    DispatchQueue.main.async {
                        self.delegate?.updateInterface(self, with: currentData)
                    }
                    
                }
            }
        }
        
        task.resume()
    }
    
    func parseJSON(withData data: Data) -> CurrentData?{
        
        let decoder = JSONDecoder()
        do {
            let currentDataData = try decoder.decode(CurrentDataData.self, from: data)
            guard let currentData = CurrentData(currentDataData: currentDataData) else {return nil}
            return currentData
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
    
    
    
}

