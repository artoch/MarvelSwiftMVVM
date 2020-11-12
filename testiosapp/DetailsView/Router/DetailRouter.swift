//
//  DetailRouter.swift
//  testiosapp
//
//  Created by Alfredo Tochon on 11/11/20.
//
import UIKit

class DetailRouter{

    var characterID:Int?
    
    
    var viewController: UIViewController{
        return createViewController()
    }
    
    private var sourceView: UIViewController?
    
    init(characterID:Int? = 0) {
        self.characterID = characterID
    }
    
    //Retorna la view de la vista
    private func createViewController() ->  UIViewController{
        let view = DetailView(nibName: "DetailView", bundle: Bundle.main)
        view.characterID = self.characterID
        return view
    }
    
    //carga el sourceview
    func setSourceView(_ sourceView: UIViewController?){
        guard let view = sourceView else {fatalError("falta error")}
        self.sourceView = view

    }
}

