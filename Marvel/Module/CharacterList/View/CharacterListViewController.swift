//
//  CharacterListVC.swift
//  Marvel
//
//  Created by Sahibuddin Ahmed on 10/02/22.
//

import Foundation
import UIKit

class CharacterListViewController : UIViewController {
    
    //MARK: Properties
    @IBOutlet weak private var collectionVw: UICollectionView!
    var characters: [CharacterCellData] = []
    var pageInfo : PageInfo? = nil
    private let indicator: ActivityIndicator = ActivityIndicator()
    let viewModel : characterListViewModelProtocol = characterListViewModel()
    
    //MARK: ViewLifeCycle
    override func viewDidLoad() {
        bindViewModel()
        configure()
        viewModel.getAllCharactersWithPagination(withOffset: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    //MARK: Method
   private func configure() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionVw.collectionViewLayout = layout
        collectionVw.register(UINib(nibName: "CharacterCVwCell", bundle: nil), forCellWithReuseIdentifier: "CharacterCVwCell")
        collectionVw.translatesAutoresizingMaskIntoConstraints = false
        collectionVw.delegate = self
        collectionVw.dataSource = self
    }
    
    private func bindViewModel() {
        viewModel.isLoading.bind(to: self) { weakSelf,loading  in
            loading ? weakSelf.indicator.showActivityIndicator(uiView: self.view!) : weakSelf.indicator.hideActivityIndicator(uiView: self.view!)
        }.dispose(in: viewModel.disposeBag)
        
        viewModel.character.bind(to: self) { weakSelf,data in
            weakSelf.characters.append(contentsOf: data ?? [])
            weakSelf.collectionVw.reloadData()
        }.dispose(in: viewModel.disposeBag)
    }
}

