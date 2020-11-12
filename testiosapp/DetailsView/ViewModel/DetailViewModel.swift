//
//  DetailViewModel.swift
//  testiosapp
//
//  Created by Alfredo Tochon on 11/11/20.
//

import Foundation
import RxSwift

class DetailViewModel {
    private var managerConnections = ManagerConnection()
    
    private(set) weak var view: DetailView?
    private var router:DetailRouter?
    
    func bind(view:DetailView,router:DetailRouter){
        self.view = view
        self.router = router
        //bindear el router con la vista
        self.router?.setSourceView(view)
    
    }
    
    func getCharacterData(characterID:Int) -> Observable<Character>{
        return managerConnections.getCharacterDetail(characterID: characterID)
    }
    
}
