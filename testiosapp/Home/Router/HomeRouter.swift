//
//  HomeRouter.swift
//  testiosapp
//
//  Created by Alfredo Tochon on 11/10/20.
//

import Foundation
import UIKit

class HomeRouter{
    //Se encarga de cargar la ruta de la vista
    var viewController: UIViewController{
        return createViewController()
    }
    private var sourceView: UIViewController?
    
    //Retorna la view de la vista
    private func createViewController() ->  UIViewController{
        let view = HomeView(nibName: "HomeView", bundle: Bundle.main)
        return view
    }
    
//    //carga el sourceview
    func setSourceView(_ sourceView: UIViewController?){
        guard let view = sourceView else {fatalError("falta error")}
        self.sourceView = view
    }
    
    //Navega a la vista detalle
    func navigateToDetailView(characterID:Int){
        let detailView = DetailRouter(characterID: characterID).viewController
        sourceView?.navigationController?.pushViewController(detailView, animated: true)
    }
}
