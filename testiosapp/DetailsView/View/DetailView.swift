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
    @IBOutlet weak var svMyView: UIStackView!
    @IBOutlet weak var detailProgress: UIActivityIndicatorView!
    @IBOutlet weak var labelError: UILabel!
    @IBOutlet weak var btnError: UIButton!
    
    
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
            self.detailProgress.stopAnimating()
            self.detailProgress.isHidden = true
            self.svMyView.isHidden = false
            self.labelTitle.text = character.name
            if character.description.isEmpty{
                self.labelDescription.text = "Sin descripción"
            }else{
                self.labelDescription.text = character.description
            }
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
                self.detailProgress.stopAnimating()
                self.detailProgress.isHidden = true
                self.btnError.isHidden = false
                self.labelError.isHidden = false
            },
            onCompleted: {
                
            })
            .disposed(by: disposeBag)
        //dar por completado la secuencia de RxSwift
    }
    
    
    @IBAction func reloadData(_ sender: Any) {
        getData()
        detailProgress.isHidden = false
        detailProgress.startAnimating()
        btnError.isHidden = true
        labelError.isHidden = true
    }
}
