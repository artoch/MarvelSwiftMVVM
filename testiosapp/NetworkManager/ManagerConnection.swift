//
//  ManagerConnection.swift
//  testiosapp
//
//  Created by Alfredo Tochon on 11/11/20.
//

import Foundation
import RxSwift
import Alamofire

class ManagerConnection {
    
    let parameters:Parameters = [
        "ts":Constants.TIMESTAMP,
        "hash":Constants.HASH,
        "apikey":Constants.PUBLIC_API_KEY
    ]
    
    func getMarvelCharacter() -> Observable<[Character]>{
        
        return Observable.create { observer in
            let url = Constants.Main.URL_MAIN + Constants.EndPoints.URL_CHARACTERS
            
            AF.request(url, method: .get,parameters: self.parameters,encoding: URLEncoding(destination: .queryString)).responseJSON { (data) in
                
                if data.response?.statusCode == 200{
                    do{
                        let decoder = JSONDecoder()
                        let characters = try decoder.decode(CharacterDataWrapper.self, from: data.data!)
                        observer.onNext(characters.data.results)
                     }catch  {
                         print(error)
                         observer.onError(error)
                    }
                }else{
                    let errorTemp = NSError(domain:"", code: data.response?.statusCode ?? 300, userInfo:nil)
                    observer.onError(errorTemp)
                    print("Error!")
                }
                observer.onCompleted()
            }
            return Disposables.create {
                AF.cancelAllRequests()
            }
        }
    }
    
    func getCharacterDetail(characterID:Int) -> Observable<Character>{
        
        return Observable.create { observer in
            let url = Constants.Main.URL_MAIN + Constants.EndPoints.URL_CHARACTERS + "/\(characterID)"
            
            AF.request(url, method: .get,parameters: self.parameters,encoding: URLEncoding(destination: .queryString)).responseJSON { (data) in
                
                if data.response?.statusCode == 200{
                    do{
                        let decoder = JSONDecoder()
                        let characters = try decoder.decode(CharacterDataWrapper.self, from: data.data!)
                        observer.onNext(characters.data.results[0])
                     }catch  {
                         print(error)
                         observer.onError(error)
                    }
                }else{
                    let errorTemp = NSError(domain:"", code: data.response?.statusCode ?? 300, userInfo:nil)
                    observer.onError(errorTemp)
                }
                observer.onCompleted()
            }
            return Disposables.create {
                AF.cancelAllRequests()
            }
        }
    }
    
}
