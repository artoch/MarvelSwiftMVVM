//
//  HomeViewModel.swift
//  testiosapp
//
//  Created by Alfredo Tochon on 11/10/20.
//

import Foundation
import RxSwift

class HomeViewModel {
    private weak var view: HomeView?
    private var router:HomeRouter?
    private var managerConnections = ManagerConnection()

    func bind(view:HomeView,router:HomeRouter){
        self.view = view
        self.router = router
        //bindear el router con la vista
        self.router?.setSourceView(view)
    }
    
    func getCharacterList() -> Observable<[Character]>{
        return managerConnections.getMarvelCharacter()
    }
    
    func makeDetailView(characterID:Int){
        router?.navigateToDetailView(characterID: characterID)
    }
}
