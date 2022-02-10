//
//  CharacterListVC.swift
//  Marvel
//
//  Created by Sahibuddin Ahmed on 10/02/22.
//

import Foundation

import UIKit

class CharacterListVC : UIViewController
{
    @IBOutlet weak var collectionVw: UICollectionView!
    
    let viewModel : characterListVMP = characterListVM()
    
    override func viewDidLoad() {
        
        viewModel.getAllCharacters()
    }
    
    func configure()
    {
        collectionVw.register(UINib(nibName: "CharacterCVwCell", bundle: nil), forCellWithReuseIdentifier: "CharacterCVwCell")
        collectionVw.translatesAutoresizingMaskIntoConstraints = false
        collectionVw.delegate = self
        collectionVw.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
}
extension CharacterListVC : UICollectionViewDelegate,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
}
