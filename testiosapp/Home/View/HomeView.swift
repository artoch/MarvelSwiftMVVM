//
//  HomeView.swift
//  testiosapp
//
//  Created by Alfredo Tochon on 11/10/20.
//

import UIKit
import RxSwift
import RxCocoa

class HomeView: UIViewController {
    
    @IBOutlet weak var homeTable: UITableView!
    @IBOutlet weak var homeProgress: UIActivityIndicatorView!
    private var disposeBag = DisposeBag()
    private var viewModel = HomeViewModel()
    private var router = HomeRouter()
    private var characters = [Character]()
    let timestamp = NSDate().timeIntervalSince1970
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myTimeInterval = TimeInterval(timestamp)
        let time = NSDate(timeIntervalSince1970: TimeInterval(myTimeInterval))
        print("\(time)")
        //Inicializo la vista
        self.navigationItem.title = "The movies App"
       // manageSearchBarController()
        configureTableView()
        viewModel.bind(view: self, router: router)
        getData()
    }
    
    private func configureTableView(){
        //configura las dimensiones automaticamente
        homeTable.delegate = self
        homeTable.dataSource = self
        homeTable.rowHeight = UITableView.automaticDimension
        homeTable.register(UINib(nibName: String(describing: HomeTableCell.self), bundle: nil), forCellReuseIdentifier: String(describing: HomeTableCell.self))
    }
    
    private func getData(){
        return viewModel.getCharacterList()
            //Manejar la concurrencia o hilos de RxSwift
            .subscribeOn(MainScheduler.instance)
            .observeOn(MainScheduler.instance)
            //Ssuscribir al observable
            .subscribe(onNext: { characters in
                self.characters = characters
                self.reloadTableView()
            }, onError: { error in
                print(error.localizedDescription)
            }, onCompleted: {
            })//Agregar un disposeBag = DisposeBag()
            .disposed(by: disposeBag)
        //dar por completado la secuencia de RxSwift
    }
    
    //Se crea un estado para actualizar la vista en el mainthread
    private func reloadTableView(){
        DispatchQueue.main.async {
            self.homeProgress.stopAnimating()
            self.homeProgress.isHidden = true
            self.homeTable.reloadData()
        }
    }
    
}

extension HomeView:UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.makeDetailView(characterID: characters[indexPath.row].id)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    //Configurar altura de las celdas
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HomeTableCell.self)) as! HomeTableCell
        cell.setupCell(characters[indexPath.row])
        return cell
    }
}
