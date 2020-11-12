//
//  DetailView.swift
//  testiosapp
//
//  Created by Alfredo Tochon on 11/11/20.
//

import UIKit
import RxSwift

class DetailView: UIViewController{
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var ivTitle: UIImageView!
    
    
    private var disposeBag = DisposeBag()
    private var viewModel = DetailViewModel()
    private var router = DetailRouter()
    var characterID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        getData()
    }
    
    private func showCharacterData(character:Character){
        DispatchQueue.main.async {
            self.labelTitle.text = character.name
            self.labelDescription.text = character.description
            self.labelName.text = character.name
            self.ivTitle.imageFromServerURL(url: "\(character.thumbnail.path)/portrait_xlarge.\(character.thumbnail.ext)", placeHolderImage: UIImage(named: "genericcomic")!)
        }
    }
    
    private func getData(){
        guard let idCharacter = characterID else {  return  }
        
        return viewModel.getCharacterData(characterID: idCharacter).subscribe(
            onNext: { character in
                self.showCharacterData(character: character)
            },
            onError: { error in
                print(error.localizedDescription)
            },
            onCompleted: {
                
            })
            .disposed(by: disposeBag)
        //dar por completado la secuencia de RxSwift
    }
}
